class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { maximum: 10 }, uniqueness: true

  has_many :transactions
  has_many :groups

  def group_transactions
    transactions.joins(:amount_relationships)
      .order(created_at: :desc)
      .includes([:groups])
  end

  def external_transactions
    transactions.joins('LEFT JOIN amount_relationships ON amount_relationships.transaction_id = transactions.id')
      .where('amount_relationships.transaction_id IS NULL')
      .order(created_at: :desc)
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
