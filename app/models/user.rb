class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :first_name, :last_name, presence: true
  validates :role, presence: true

  enum role: { admin: 0, user: 1 }

  default_scope { where(deleted: false) }
end
