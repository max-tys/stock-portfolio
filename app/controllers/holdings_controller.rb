require 'pry'

class HoldingsController < ApplicationController
  # GET /holdings/39
  def show
    @holding = Holding.find(params[:id])
    # https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
    @portfolio = @holding.portfolio
  end

  # POST /portfolios/45/holdings
  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    # https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many
    # Return value: a new child object that hasn't been saved.
    # Side effect: child object is linked to the collection until the collection is modified.
    @holding = @portfolio.holdings.build(holding_params)

    # https://api.rubyonrails.org/classes/ActionController/MimeResponds.html#method-i-respond_to
    respond_to do |format|
      # https://guides.rubyonrails.org/active_record_validations.html#when-does-validation-happen-questionmark
      if @holding.save
        format.html { redirect_to portfolio_path(@portfolio), notice: "Added #{@holding.symbol} to portfolio." }
      else
        # Reassign @portfolio because @portfolio.holdings.build adds an entry to the @portfolio.holdings object, even if @holding isn't saved to the database.
        @portfolio = Portfolio.find(params[:portfolio_id])
        # https://api.rubyonrails.org/classes/ActionView/Template.html#method-i-render
        format.html { render "portfolios/show", status: :unprocessable_entity }
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
