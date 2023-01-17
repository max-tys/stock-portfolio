class HoldingsController < ApplicationController
  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.create(holding_params)
    redirect_to portfolio_path(@portfolio)
  end

  def destroy
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.find(params[:id])
    @holding.destroy
    redirect_to portfolio_path(@portfolio), status: :see_other
  end

  private

  # Only allow a list of trusted parameters through.
  def holding_params
    params.require(:holding).permit(:symbol)
  end
end
