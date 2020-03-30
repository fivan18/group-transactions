class Transaction < ApplicationRecord
  belongs_to :user
  has_many :amount_relationships
  has_many :groups, through: :amount_relationships

  validates :name, presence: true, length: { in: 6..30 }
  validates :amount, presence: true
end