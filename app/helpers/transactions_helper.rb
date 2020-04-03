module TransactionsHelper
  def amount_transactions(transactions)
    amount = 0
    transactions.each do |transaction|
      amount += transaction.amount
    end
    amount
  end

  def redirect_to_stored_location(default, group_id)
    location = stored_location_for(:user)
    if location == group_path(group_id)
      redirect_to location || root_url
    else
      redirect_to default
    end
  end
end
