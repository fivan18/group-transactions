module TransactionsHelper
  def amount_transactions(transactions)
    amount = 0
    transactions.each do |transaction|
      amount += transaction.amount
    end
    amount
  end
end