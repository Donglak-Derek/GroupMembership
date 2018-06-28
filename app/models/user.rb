class User < ActiveRecord::Base
  has_secure_password

  has_many :groups
  has_many :joins
  has_many :groups_joined, through: :joins, source: :groups

  validates :first_name, :last_name, :email, presence: true

  def full_name
  	"#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end
end
