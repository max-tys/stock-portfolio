class HoldingsController < ApplicationController
  # GET /holdings/39
  def show
    @holding = Holding.find(params[:id])
    @portfolio = @holding.portfolio
  end

  # POST /portfolios/45/holdings
  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @new_holding = @portfolio.holdings.new(holding_params)

    respond_to do |format|
      if @new_holding.save
        format.html { redirect_to portfolio_path(@portfolio), notice: "Added #{@new_holding.symbol} to portfolio." }
      else
        format.html { render 'portfolios/show', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holdings/39
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
