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
require 'rails_helper'

RSpec.describe Booking::LineItem, type: :model do
  context 'with associations and validations' do
    it { is_expected.to belong_to(:booking_order) }

    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:subtotal) }
    it { is_expected.to validate_presence_of(:tax) }
    it { is_expected.to validate_presence_of(:total) }
    it { is_expected.to validate_presence_of(:booking_order) }
  end
end
