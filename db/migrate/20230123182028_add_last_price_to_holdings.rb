class AddLastPriceToHoldings < ActiveRecord::Migration[7.0]
  def change
    add_column :holdings, :last_price, :decimal
  end
end
