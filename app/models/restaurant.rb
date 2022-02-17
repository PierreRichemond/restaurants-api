class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :name, presence: true
  validates :address, presence: true
end
