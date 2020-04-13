class TransactionsController < ApplicationController
  before_action :store_user_location!, only: %i[group_transactions external_transactions],
                                       if: :storable_location?
  before_action :authenticate_user!

  def new
    @transaction = Transaction.new
    @selected_group = group_params[:selected_group]
  end

  def create
    @transaction = current_user.transactions.create(transaction_params)
    if @transaction.id
      group_id = group_params[:group_id]
      if group_id.empty?
        flash[:success] = 'Transaction created!'
        redirect_to external_transactions_path
      else
        verify_amount(@transaction, group_id)
      end
    else
      @selected_group = group_params[:group_id]
      render 'new'
    end
  end

  def group_transactions
    @transactions = current_user.group_transactions
    @amount = @transactions.sum('amount')
  end

  def external_transactions
    @transactions = current_user.external_transactions
    @amount = @transactions.sum('amount')
  end

  private

  def group_params
    params.require(:group).permit(:group_id, :selected_group)
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
