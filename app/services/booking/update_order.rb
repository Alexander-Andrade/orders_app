# frozen_string_literal: true

module Booking
  class UpdateOrder
    attr_reader :order, :order_params

    def initialize(order, order_params)
      @order = order
      @order_params = order_params
    end

    def call
      ActiveRecord::Base.transaction do
        calculate_line_items_fields
        calculate_order_fields

        order.save!
      end

      order
    end

    private

    def calculate_line_items_fields
      items_to_calculate = order_params[:line_items_attributes].map do |line_item_attributes|
        order.line_items.find_or_initialize_by(id: line_item_attributes.fetch(:id, nil)).
          tap do |line_item|
          line_item.assign_attributes(line_item_attributes)
        end
      end

      items_to_calculate.each { |line_item| LineItemCalculator.new(line_item).call }
      items_to_calculate.each(&:save!)
    end

    def calculate_order_fields
      order.subtotal = order.line_items.sum(:subtotal)
      order.tax = order.line_items.sum(:tax)
      order.total = order.line_items.sum(:total)
    end
  end
end
