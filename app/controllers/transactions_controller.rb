class TransactionsController < ApplicationController
  before_action :store_user_location!, only: [:group_transactions, :external_transactions], 
                                       if: :storable_location?
  before_action :authenticate_user!
  
  def new; end

  def create
    transaction = current_user.transactions.create(transaction_params)
    if transaction
      group_id = group_params[:group_id]
      transaction.groups << Group.find(group_id) unless group_id.empty?
      redirect_to stored_location_for(:user) || root_url
    else
      render 'new'
    end
  end

  def group_transactions
    @transactions = current_user.group_transactions
    @amount = amount_transactions(@transactions)
  end

  def external_transactions
    @transactions = current_user.external_transactions
    @amount = amount_transactions(@transactions)
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