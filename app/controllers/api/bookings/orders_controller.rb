# frozen_string_literal: true

module Api
  module Bookings
    class OrdersController < ApplicationController
      before_action :validate_params, only: %i[create update]

      def create
        order_params_result
        order = ::Booking::CreateOrder.new(order_params).call

        render json: order, serializer: ::Booking::OrderSerializer,
               root: 'order',
               status: :created
      end

      def update
        order = ::Booking::Order.find(params[:id])

        order = ::Booking::UpdateOrder.new(order, order_params).call

        render json: order, serializer: ::Booking::OrderSerializer,
               root: 'order'
      end

      private

      def validate_params
        render_params_error(order_params_result)
      end

      def order_params_result
        @order_params_result ||=
          ::Booking::OrderParamsValidator.new.call(order_params.to_h)
      end

      def order_params
        keys = [
          line_items_attributes: [
            :id,
            :quantity,
            :amount
          ]
        ]

        params.require(:order).permit(*keys)
      end
    end
  end
end
