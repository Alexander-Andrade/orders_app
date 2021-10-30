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
class Booking::Order < ApplicationRecord
  has_many :booking_line_items, class_name: 'Booking::LineItem',
                                foreign_key: 'booking_order_id', dependent: :destroy

  accepts_nested_attributes_for :booking_line_items
  validates :subtotal, :tax, :total, :booking_line_items, presence: true
end
