class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 10 }

end