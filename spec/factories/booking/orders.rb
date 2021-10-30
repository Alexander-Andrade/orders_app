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
FactoryBot.define do
  factory :booking_order do
    subtotal { 0.0 }
    tax { 0.0 }
    total { 0.0 }
  end
end
