class Product < ActiveRecord::Base
  attr_accessible :name, :billing_frequency
  
  # this product belongs to a user
  belongs_to :user

  # make sure that user id isn't blank
  validates :user_id, presence: true

  # make sure that name isn't blank and its maximum length is 100 characters
  validates :name, presence: true, length: { maximum: 100 }

  # make sure that billing frequency isn't blank
  validates :billing_frequency, presence: true

  # arrange in descending order from newest to oldest
  default_scope order: 'products.created_at DESC'
end
