# Handles requests that pertain to portfolios generally.
class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[edit update destroy]

  # GET /portfolios (portfolios)
  # rubocop:disable Metrics/MethodLength
  def index
    # Update last prices for all holdings
    Holding.all.each do |holding|
      last_price = get_last_price(holding)
      holding.update(last_price:)
    end

    # Returns a Portfolio::ActiveRecord_Relation collection object.
    @portfolios = Portfolio.select("
        portfolios.id,
        portfolios.name,
        SUM(transactions.quantity * transactions.price) AS amount_invested,
        SUM(transactions.quantity * holdings.last_price) AS current_value
      ")
                           .left_outer_joins(holdings: :transactions)
                           .group('portfolios.id')
                           .order('portfolios.name')
  end

  # GET /portfolios/1 (portfolio)
  def show
    # Portfolio#find returns a single Portfolio object. This serves as a model for helpers that generate paths.
    @portfolio = set_portfolio

    # Returns a Relation object, which is a collection of multiple Holding objects.
    @portfolio_holdings = Holding.select("
      holdings.id,
      holdings.symbol,
      SUM(quantity) AS quantity,
      (SUM(price * quantity) / SUM(quantity)) AS average_cost
    ")
      .left_outer_joins(:transactions)
      .where(portfolio_id: params[:id])
      .group('holdings.id')
      .order('holdings.symbol')
  end
  # rubocop:enable Metrics/MethodLength

  # GET /portfolios/new (new_portfolio)
  def new
    @portfolio = Portfolio.new
  end

  # GET /portfolios/1/edit (edit_portfolio)
  def edit; end

  # POST /portfolios (portfolios)
  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to portfolio_url(@portfolio), notice: 'Portfolio was successfully created.' }
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
        format.html { redirect_to portfolio_url(@portfolio), notice: 'Portfolio was successfully renamed.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1 (portfolio)
  def destroy
    @portfolio.destroy

    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully deleted.' }
    end
  end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:name)
  end
end
