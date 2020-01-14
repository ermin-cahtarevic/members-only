class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email
  before_create :create_remember_digest

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end 

  def User.digest(string)
    Digest::SHA1.hexdigest string
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end  

  private

  def downcase_email
    email.downcase!
  end  

  def create_remember_digest
    self.remember_token  = User.new_token
    self.remember_digest = User.digest(remember_token)
  end  
end