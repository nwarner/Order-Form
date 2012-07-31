class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :products, dependent: :destroy

  # make sure that emails are downcased before being saved to the db
  before_save { self.email.downcase! }

  # create remember token
  before_save :create_remember_token

  # make sure that name is non-blank and is a maximum of 50 characters
  validates :name, presence: true, length: { maximum: 50 }

  # make sure that email is non-blank and is a valid email address,
  # ignoring case
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
		    uniqueness: { case_sensitive: false }
  # make sure that password is non-blank and is at least 6 characters long
  validates :password, presence: true, length: { minimum: 6 }

  # make sure that password confirmation is non-blank
  validates :password_confirmation, presence: true

  def display
    # This is preliminary.
    Product.where("user_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
