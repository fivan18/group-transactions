class TransactionsController < ApplicationController
  before_action :store_user_location!, only: %i[group_transactions external_transactions],
                                       if: :storable_location?
  before_action :authenticate_user!

  def new
    @transaction = Transaction.new
    @selected_group = params[:selected_group]
  end

  def create
    @transaction = current_user.transactions.create(transaction_params)
    if @transaction.id
      flash[:success] = 'Transaction created!'
      group_id = group_params[:group_id]
      @transaction.groups << Group.find(group_id) unless group_id.empty?
      if group_id.empty?
        redirect_to external_transactions_path
      else
        redirect_to_stored_location(group_transactions_path, group_id)
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

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def group_params
    params.require(:group).permit(:group_id)
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end
end
