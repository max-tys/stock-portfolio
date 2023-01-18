class HoldingsController < ApplicationController
  def show
    @holding = Holding.find(params[:id])
    @portfolio = @holding.portfolio
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
    @holding = Holding.find(params[:id])
    @portfolio = @holding.portfolio
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
