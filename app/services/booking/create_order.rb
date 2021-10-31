# frozen_string_literal: true

module Booking
  class CreateOrder
    attr_reader :order_params

    def initialize(order_params)
      @order_params = order_params
    end

    def call
      calculated_line_item_fields
      calculate_order_fields

      order.save!

      order
    end

    private

    def order
      @order ||= ::Booking::Order.new(order_params)
    end

    def sum_line_items_field(field)
      order.line_items.map(&field).reduce(0, :+)
    end

    def calculated_line_item_fields
      order.line_items.each do |line_item|
        LineItemCalculator.new(line_item).call
      end
    end

    def calculate_order_fields
      order.subtotal = sum_line_items_field(:subtotal)
      order.tax = sum_line_items_field(:tax)
      order.total = sum_line_items_field(:total)
    end
  end
end
