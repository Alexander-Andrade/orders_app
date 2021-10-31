# frozen_string_literal: true

require 'rails_helper'


describe ::Api::Bookings::OrdersController, type: :request do
  describe 'POST /api/bookings/orders' do
    let(:request) do
      post "/api/bookings/orders", params: { order: order_params }
    end

    context 'with valid order params' do
      let(:order_params) do
        {
          line_items_attributes: [
            { quantity: 2, amount: 10 },
            { quantity: 1, amount: 20 }
          ]
        }
      end

      it 'creates an order' do
        expect { request }.to change { Booking::Order.count }.by(1)
      end

      it 'creates line items' do
        expect { request }.to change { Booking::LineItem.count }.by(2)
      end

      it 'calculates the order values correctly' do
        request

        order = ::Booking::Order.last
        aggregate_failures do
          expect(order.subtotal).to eq 40
          expect(order.tax).to eq 3.2
          expect(order.total).to eq 43.2
        end
      end

      it 'calculates line items values correctly' do
        request

        line_item = ::Booking::LineItem.last
        aggregate_failures do
          expect(line_item.subtotal).to eq 20
          expect(line_item.tax).to eq 1.6
          expect(line_item.total).to eq 21.6
        end
      end

      it 'returns the order' do
        request

        parsed_body = JSON.parse(response.body)
        aggregate_failures do
          expect(parsed_body).to have_key('order')
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'with malformed order params' do
      let(:order_params) do
        {
          line_items_attributes: [
            { amount: 10 },
            { some_malform_key: 'data' }
          ]
        }
      end

      it 'does not create an order' do
        expect { request }.not_to change { Booking::Order.count }
      end

      it 'returns unprocessable entity' do
        request

        aggregate_failures do
          expect(response.body).to include 'errors'
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'with no orders' do
      let(:order_params) do
        {
          line_items_attributes: []
        }
      end

      it 'returns unprocessable entity' do
        request

        aggregate_failures do
          expect(response.body).to include 'errors'
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'PATCH /api/bookings/orders/:id' do
    let(:order) do
      order = build(:booking_order)
      order.line_items = build_list(:booking_line_items, 2, order: order)
      order.save
      order
    end
    let(:line_items) { order.line_items }
    let(:order_params) do
      {
        line_items_attributes: [
          { id: nil, quantity: 1, amount: 5 },
          { id: line_items.first.id, quantity: 2, amount: 10 },
          { id: line_items.second.id, quantity: 3, amount: 30 }
        ]
      }
    end

    context 'with valid order' do
      let(:request) do
        patch "/api/bookings/orders/#{order.id}",
              params: { order: order_params }
      end


      it 'returns the order' do
        request

        parsed_body = JSON.parse(response.body)
        aggregate_failures do
          expect(parsed_body).to have_key('order')
          expect(response).to have_http_status(:ok)
        end
      end

      it 'calculates line items values correctly' do
        request

        updated_line_item = line_items.second.reload
        created_line_item = ::Booking::LineItem.where.
          not(id: line_items.map(&:id)).first

        aggregate_failures do
          expect(updated_line_item.subtotal).to eq 90
          expect(updated_line_item.tax).to eq 7.2
          expect(updated_line_item.total).to eq 97.2

          expect(created_line_item.subtotal).to eq 5
          expect(created_line_item.tax).to eq 0.4
          expect(created_line_item.total).to eq 5.4
        end
      end

      it 'calculates line orders values correctly' do
        request

        aggregate_failures do
          expect(order.reload.subtotal).to eq 115
          expect(order.tax.to_f).to eq 9.2
          expect(order.total).to eq 124.2
        end
      end
    end

    context 'without the order' do
      let(:request) do
        patch "/api/bookings/orders/1",
              params: { order: order_params }
      end

      it 'returns not found' do
        request

        aggregate_failures do
          expect(response.body).to include 'errors'
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
