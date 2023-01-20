class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[ edit update destroy ]

  # GET /portfolios
  def index
    # https://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html#method-i-all
    @portfolios = Portfolio.select(
      [
        :name, NamedFunction.new(
          'SUM', [Transaction[:price] * Transaction[:quantity]]
        )
      ]
    ).joins(
      Portfolio.arel_table.join(Holding.arel_table).on(Holding[:portfolio_id].eq(Portfolio[:id])).join_sources
    ).joins(
      Portfolio.arel_table.join(Transaction.arel_table).on(Transaction[:holding_id].eq(Holding[:id])).join_sources
    ).group(Portfolio[:id])
    
    @portfolio = Portfolio.new
  end

  # GET /portfolios/1
  def show
    @holding = Holding.new
    # https://guides.rubyonrails.org/active_record_querying.html#nested-associations-hash
    # Finds a single portfolio and eager load all the associated holdings for it, as well as the transactions for all of the holdings. Prevents a nested N+1 problem.
    @portfolio = Portfolio.includes(holdings: :transactions).find(params[:id])
  end
  
  # GET /portfolios/1/edit
  def edit
  end

  # POST /portfolios
  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to portfolio_url(@portfolio), notice: "Portfolio was successfully created." }
      else
        @portfolios = Portfolio.all
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolios/1
  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to portfolio_url(@portfolio), notice: "Portfolio was successfully renamed." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1 or /portfolios/1.json
  def destroy
    @portfolio.destroy

    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: "Portfolio was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portfolio_params
      params.require(:portfolio).permit(:name)
    end
end
