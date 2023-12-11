class AddDiscountedTotalToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :discounted_total, :decimal
  end
end
