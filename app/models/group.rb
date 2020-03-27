class Group < ApplicationRecord
  belongs_to :user
  has_many :amount_relationships
  has_many :transactions, through: :amount_relationships, source: :m_transaction
end