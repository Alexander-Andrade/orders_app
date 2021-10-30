# frozen_string_literal: true

# == Schema Information
#
# Table name: booking_line_items
#
#  id               :bigint           not null, primary key
#  amount           :decimal(16, 2)   not null
#  quantity         :decimal(16, 2)   not null
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
FactoryBot.define do
  factory :booking_line_items do
    booking_order

    quantity { 0.0 }
    amount { 0.0 }
    subtotal { 0.0 }
    tax { 0.0 }
    total { 0.0 }
  end
end
