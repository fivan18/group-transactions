class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { maximum: 10 }, uniqueness: true

  has_many :transactions
  has_many :groups

  def group_transactions
    transactions.select { |transaction| !transaction.groups.empty? }.sort do |a, b| 
      b.created_at <=> a.created_at
    end
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