class AddDatetimeToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :datetime, :datetime
  end
end
