class Transaction < ApplicationRecord
  belongs_to :user
  has_many :amount_relationships
  has_many :groups, through: :amount_relationships
end