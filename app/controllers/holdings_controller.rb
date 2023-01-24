# Handles requests that pertain to holdings within a portfolio.
class HoldingsController < ApplicationController
  before_action :set_holding, only: %i[show destroy]

  # GET /holdings/39
  def show
    # https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
    @portfolio = @holding.portfolio
    @transaction = Transaction.new
  end

  # GET /portfolios/1/holdings/new (new_portfolio_holding)
  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = Holding.new
  end

  # POST /portfolios/45/holdings
  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    # https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many
    # Return value: a new child object that hasn't been saved.
    # Side effect: child object is linked to the collection until the collection is modified.
    @holding = @portfolio.holdings.build(holding_params)

    respond_to do |format|
      if @holding.save
        format.html { redirect_to portfolio_path(@portfolio), notice: "Added #{@holding.symbol} to portfolio." }
      else
        # Reassign @portfolio to remove the invalid holding that was temporarily added to it.
        @portfolio = Portfolio.find(params[:portfolio_id])
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holdings/39
  def destroy
    @portfolio = @holding.portfolio
    symbol = @holding.symbol
    @holding.destroy
    redirect_to portfolio_path(@portfolio), status: :see_other, notice: "Deleted #{symbol} from portfolio."
  end

  private

  def set_holding
    @holding = Holding.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def holding_params
    params.require(:holding).permit(:symbol)
  end
end
