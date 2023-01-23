module HoldingsHelper
  def get_attributes(holding)
    quantity = get_quantity(holding)
    last_price = get_last_price(holding)
    {
      symbol: holding.symbol,
      quantity: number_format(get_quantity(holding)),
      average_cost: "$ #{number_format(get_average_cost(holding))}",
      last_price: "$ #{number_format(last_price)}",
      current_value: "$ #{number_format(get_current_value(quantity, last_price))}"
    }
  end

  private

  def get_quantity(holding)
    holding.quantity.nil? ? 0 : holding.quantity
  end

  def get_average_cost(holding)
    holding.average_cost.nil? ? 0 : holding.average_cost
  end

  def get_last_price(holding)
    begin
      ApplicationController.finnhub_client.quote(holding.symbol).c
    rescue FinnhubRuby::ApiError
      '-'
    end
  end

  def get_current_value(quantity, last_price)
    begin
      quantity * last_price
    # Rescue if there are no transactions for a given holding
    rescue NoMethodError
      '-'
    end
  end
end
