class TransactionsController < ApplicationController
  def group_transactions
    @transactions = current_user.group_transactions
  end
end