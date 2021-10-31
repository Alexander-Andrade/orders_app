class CreateBookingOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :booking_orders do |t|
      t.decimal :subtotal, precision: 16, scale: 2, null: false
      t.decimal :tax, precision: 16, scale: 2, null: false
      t.decimal :total, precision: 16, scale: 2, null: false

      t.timestamps
    end

    create_table :booking_line_items do |t|
      t.references :booking_order, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :amount, null: false
      t.decimal :subtotal, precision: 16, scale: 2, null: false
      t.decimal :tax, precision: 16, scale: 2, null: false
      t.decimal :total, precision: 16, scale: 2, null: false

      t.timestamps
    end
  end
end
