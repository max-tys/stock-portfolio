class CreateHoldings < ActiveRecord::Migration[7.0]
  def change
    create_table :holdings do |t|
      t.text :symbol
      t.references :portfolio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
