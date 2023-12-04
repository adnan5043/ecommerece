class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :order, foreign_key: true
      t.string :title
      t.decimal :price
      t.integer :quantity
      t.decimal :fee_charges

      t.timestamps
    end
  end
end
