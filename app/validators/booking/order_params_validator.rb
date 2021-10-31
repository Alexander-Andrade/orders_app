# frozen_string_literal: true

module Booking
  class OrderParamsValidator < Dry::Validation::Contract
    params do
      required(:line_items_attributes).value(:array).each do
        hash do
          optional(:id)
          required(:quantity).value(:integer)
          required(:amount).value(:integer)
        end
      end
    end
  end
end
