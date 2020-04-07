class Group < ApplicationRecord
  belongs_to :user
  has_many :amount_relationships
  has_many :transactions, through: :amount_relationships, source: :m_transaction
  has_one_attached :avatar

  validates :name, presence: true, length: { in: 6..30 }
  validates :avatar, attached: true, content_type: %i[png jpg jpeg]

  def sorted_transactions
    transactions.order(created_at: :desc)
      .includes(%i[groups user])
  end
end
