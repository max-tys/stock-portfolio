class HoldingsController < ApplicationController
  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.new(holding_params)
    respond_to do |format|
      if @holding.save
        format.html { redirect_to portfolio_path(@portfolio), notice: "Added holding to portfolio." }
      else
        format.html { render @portfolio, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.find(params[:id])
    @holding.destroy
    redirect_to portfolio_path(@portfolio), status: :see_other
  end

  def show
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.find(params[:id])
  end

  private

  # Only allow a list of trusted parameters through.
  def holding_params
    params.require(:holding).permit(:symbol)
  end
end
