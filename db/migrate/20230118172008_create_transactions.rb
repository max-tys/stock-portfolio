class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :price
      t.decimal :quantity
      t.references :holding, null: false, foreign_key: true

      t.timestamps
    end
  end
end
