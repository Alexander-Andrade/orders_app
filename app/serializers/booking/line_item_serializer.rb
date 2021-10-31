# frozen_string_literal: true

# == Schema Information
#
# Table name: booking_line_items
#
#  id               :bigint           not null, primary key
#  amount           :integer          not null
#  quantity         :integer          not null
#  subtotal         :decimal(16, 2)   not null
#  tax              :decimal(16, 2)   not null
#  total            :decimal(16, 2)   not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  booking_order_id :bigint           not null
#
# Indexes
#
#  index_booking_line_items_on_booking_order_id  (booking_order_id)
#
# Foreign Keys
#
#  fk_rails_...  (booking_order_id => booking_orders.id)
#
module Booking
  class LineItemSerializer < ActiveModel::Serializer
    attributes %i[
      id
      quantity
      amount
      subtotal
      tax
      total
    ]
  end
end
