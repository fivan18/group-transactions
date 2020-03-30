class Group < ApplicationRecord
  belongs_to :user
  has_many :amount_relationships
  has_many :transactions, through: :amount_relationships, source: :m_transaction
  has_one_attached :avatar

  validates :name, presence: true, length: { in: 6..30 }
  validates :avatar, attached: true, content_type: [:png, :jpg, :jpeg]

  def sorted_transactions
    transactions.sort { |a, b| b.created_at <=> a.created_at }
  end
end