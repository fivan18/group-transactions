class TransactionsController < ApplicationController
  before_action :authenticate_user!
  
  def new; end

  def create
    transaction = current_user.transactions.create(transaction_params)
    if transaction
      group_id = group_params[:group_id]
      transaction.groups << Group.find(group_id) unless group_id.empty?
      redirect_to root_url
    else
      render 'new'
    end
  end

  def group_transactions
    @transactions = current_user.group_transactions
    @amount = amount_transactions(@transactions)
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end

  def group_params
    params.require(:group).permit(:group_id)
  end
end