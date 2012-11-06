class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation #password_confirmation exists only in the model (i.e. in memory) - NOT in the database
  has_secure_password #Next, we need to add password and password_confirmation attributes, require the presence of the password, require that they match, and add #an authenticate method to compare an encrypted password to the password_digest to authenticate users. This is the only nontrivial step, and in the latest version #of Rails all these features come for free with one method, has_secure_password   -- As long as there is a password_digest column in the database, adding this one #method to our model gives us a secure way to create and authenticate new users. http://ruby.railstutorial.org/chapters/modeling-users#sec-has_secure_password

  before_save { |user| user.email = email.downcase } # a callback http://ruby.railstutorial.org/chapters/modeling-users#code-email_downcase

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end



