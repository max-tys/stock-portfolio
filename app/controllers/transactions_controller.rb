# Handles requests that only pertain to transactions.
class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[edit update destroy]

  def new
    @holding = Holding.find(params[:holding_id])
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit, prefix: edit_transaction
  def edit
    @holding = @transaction.holding
  end

  # POST /holdings/1/transactions, prefix: holding_transactions
  # rubocop:disable Metrics/MethodLength
  def create
    @holding = Holding.find(params[:holding_id])
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to holding_path(@holding), notice: 'Transaction was successfully created.' }
      else
        @holding = Holding.find(params[:holding_id])
        @portfolio = @holding.portfolio
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  # PATCH/PUT /transactions/1
  def update
    @holding = @transaction.holding

    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to holding_path(@holding), notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1, prefix: transaction
  def destroy
    @holding = @transaction.holding
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to @holding, notice: 'Transaction was successfully deleted.' }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:price, :quantity, :holding_id)
  end
end
