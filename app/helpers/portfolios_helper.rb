module PortfoliosHelper
  def get_portfolio_attributes(portfolio)
    {
      name: portfolio.name,
      amount_invested: "$ #{number_format(get_amount_invested(portfolio))}",
      current_value: "$ #{number_format(0)}",
      delta: "#{number_format(0)} %"
    }
  end

  private

  def get_amount_invested(portfolio)
    portfolio.amount_invested.nil? ? 0 : portfolio.amount_invested
  end
end
