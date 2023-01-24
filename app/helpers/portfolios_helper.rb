# # Wraps portfolio attributes in a hash for ease of retrieval.
module PortfoliosHelper
  def get_portfolio_attributes(portfolio)
    amount_invested = get_amount_invested(portfolio)
    current_value = get_portfolio_current_value(portfolio)
    delta = get_delta(amount_invested, current_value)

    {
      name: portfolio.name,
      amount_invested: "$ #{number_format(amount_invested)}",
      current_value: "$ #{number_format(current_value)}",
      delta: "#{number_format(delta)} %"
    }
  end

  def get_amount_invested(portfolio)
    portfolio.amount_invested.nil? ? 0 : portfolio.amount_invested
  end

  def get_portfolio_current_value(portfolio)
    portfolio.current_value.nil? ? 0 : portfolio.current_value
  end

  def get_delta(amount_invested, current_value)
    100 * (current_value - amount_invested) / amount_invested
  # Rescue if there are no transactions within this portfolio.
  rescue ZeroDivisionError
    0
  end
end
