module TransactionsHelper
  def redirect_to_stored_location(default, group_id)
    location = stored_location_for(:user)
    if location == group_path(group_id)
      redirect_to location || root_url
    else
      redirect_to default
    end
  end

  def verify_amount(transaction, group_id)
    group = Group.find(group_id)
    if transaction.amount < group.minimum_amount
      flash[:alert] = "The minimum amount to contribute is $#{group.minimum_amount}"
      transaction.destroy
      @selected_group = group_id
      render 'new'
    else
      transaction.groups << group
      flash[:success] = 'Transaction created!'
      redirect_to_stored_location(group_transactions_path, group_id)
    end
  end
end
