class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 10 }

  has_many :transactions
  has_many :groups

  def group_transactions
    transactions.select { |transaction| !transaction.groups.empty? }
  end
end