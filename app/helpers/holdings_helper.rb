module HoldingsHelper
  def last_price(symbol)
    begin
      ApplicationController.finnhub_client.quote(symbol).c
    rescue FinnhubRuby::ApiError
      '-'
    end
  end

  def current_value(quantity, price)
    begin
      number_format(quantity * price)
    # Rescue if there are no transactions for a given holding
    rescue NoMethodError
      '-'
    end
  end
end
