class AmountRelationship < ApplicationRecord
  belongs_to :m_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
  belongs_to :group
end
