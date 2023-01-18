class HoldingsController < ApplicationController
  def show
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.find(params[:id])
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.new(holding_params)
    respond_to do |format|
      if @holding.save
        format.html { redirect_to portfolio_path(@portfolio), notice: "Added #{@holding.symbol} to portfolio." }
      else
        format.html { render "portfolios/show", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.find(params[:id])
    symbol = @holding.symbol
    @holding.destroy
    redirect_to portfolio_path(@portfolio), status: :see_other, notice: "Deleted #{symbol} from portfolio."
  end

  private

  # Only allow a list of trusted parameters through.
  def holding_params
    params.require(:holding).permit(:symbol)
  end
end
