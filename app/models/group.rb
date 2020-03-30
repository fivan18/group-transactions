class Group < ApplicationRecord
  belongs_to :user
  has_many :amount_relationships
  has_many :transactions, through: :amount_relationships, source: :m_transaction

  has_one_attached :avatar

  def sorted_transactions
    transactions.sort { |a, b| b.created_at <=> a.created_at }
  end
end