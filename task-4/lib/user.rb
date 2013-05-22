require 'active_record'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  validates :name, :surname, :email, :password, presence: true
  validates :name, length: { in: 2..20 }
  validates :surname, length: { in:  2..30 }
  validates :password, length: { in: 3..10 }
 
 
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end

