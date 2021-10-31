# frozen_string_literal: true

module Booking
  class LineItemCalculator
    attr_reader :line_item

    def initialize(line_item)
      @line_item = line_item
    end

    def call
      line_item.subtotal = line_item.quantity * line_item.amount
      line_item.tax = line_item.subtotal * ::Booking::LineItem::TAX_RATE
      line_item.total = line_item.subtotal + line_item.tax

      line_item
    end
  end
end
