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
require 'rails_helper'

RSpec.describe Booking::Order, type: :model do
  context 'with associations and validations' do
    it { is_expected.to have_many(:booking_line_items) }

    it { is_expected.to validate_presence_of(:subtotal) }
    it { is_expected.to validate_presence_of(:tax) }
    it { is_expected.to validate_presence_of(:total) }
    it { is_expected.to validate_presence_of(:booking_line_items) }
  end
end
