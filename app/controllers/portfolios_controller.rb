class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[ edit update destroy ]

  # GET /portfolios (portfolios)
  def index
    # https://guides.rubyonrails.org/active_record_querying.html#calculations
    # #select, #left_outer_joins, and #group all return a Portfolio::ActiveRecord_Relation collection object.
      # This object looks like an array, but it is not.
      # You can append other query methods to the Relation object.
      # Each 'row' in the Relation object is an object of the Portfolio class.
    # The return value of the method chain is [#<Portfolio:0x00007fd6e739f920 id: 70, name: "USA">, #<Portfolio:0x00007fd6e739f808 id: 71, name: "ETF">]
    @portfolios = Portfolio.select(:id, :name, "SUM(price * quantity) AS invested")
      .left_outer_joins(holdings: :transactions)
      .group(:id)
  end

  # GET /portfolios/new (new_portfolio)
  def new
    @portfolio = Portfolio.new
  end

  # GET /portfolios/1 (portfolio)
  def show
    # https://guides.rubyonrails.org/active_record_querying.html#nested-associations-hash
    @portfolio = Portfolio.find(params[:id])

    @portfolio_holdings = Portfolio.select("
        holdings.id, 
        holdings.symbol, 
        SUM(quantity) AS quantity, 
        (SUM(price * quantity) / SUM(quantity)) AS wac
      ")
      .left_outer_joins(holdings: :transactions)
      .where(["portfolio_id = ?", params[:id]])
      .group("holdings.id")
      .order("holdings.symbol")
  end
  
  # GET /portfolios/1/edit (edit_portfolio)
  def edit
  end

  # POST /portfolios (portfolios)
  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to portfolio_url(@portfolio), notice: "Portfolio was successfully created." }
      else
        @portfolios = Portfolio.all
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolios/1 (portfolio)
  def update
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to portfolio_url(@portfolio), notice: "Portfolio was successfully renamed." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1 (portfolio)
  def destroy
    @portfolio.destroy

    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: "Portfolio was successfully deleted." }
    end
  end

  private
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def portfolio_params
      params.require(:portfolio).permit(:name)
    end
end
