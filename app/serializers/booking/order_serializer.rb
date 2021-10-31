# frozen_string_literal: true

# == Schema Information
#
# Table name: booking_orders
#
#  id         :bigint           not null, primary key
#  subtotal   :decimal(16, 2)   not null
#  tax        :decimal(16, 2)   not null
#  total      :decimal(16, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Booking
  class OrderSerializer < ActiveModel::Serializer
    attributes %i[
      id
      subtotal
      tax
      total
    ]

    has_many :line_items,
             serializer: ::Booking::LineItemSerializer
  end
end
