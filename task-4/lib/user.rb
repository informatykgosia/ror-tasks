require 'active_record'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :surname, :name, :password, :email, 
    :password_confirmation, :terms_of_the_service

  has_many :todo_list, dependent: :destroy
  has_many :todo_items, through: :todo_lists

  email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :surname, :email, :password, presence: true
  validates :name, length: { in: 2..20 }
  validates :surname, length: { in:  2..30 }
  validates :password, length: { in: 3..10 }
  validates :password, confirmation: true
  validates :terms_of_the_service, acceptance: { accept: true }, allow_nil: false

  validates :email,
    :format => { :with => email_format, :message => 'e-mail niepoprawny'}


  def password
    Password.new(super)
  end

  def password=(new_password)
    super(Password.create(new_password))
  end

  def self.find_by_surname(surname)
    where("surname = ?", surname).first
  end

  def self.find_by_email(email)
    where("email = ?", email).first
  end

  def self.authenticate(email, password)
    if (user = find_by_email(email))
      if user.password == password
	return true
      end
      user.update_attribute(:failed_login_count, user.failed_login_count += 1)
    end
    return false
  end

  def self.find_suspicious
    where("failed_login_count > 2")
  end
end
  
