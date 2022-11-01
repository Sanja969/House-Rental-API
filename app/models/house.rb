class House < ApplicationRecord
  has_many :reservations, foreign_key: 'house_id'
  belongs_to :user, foreign_key: 'user_id'

  validates :name, presence: true, length: { maximum: 250 }
  validates :image_data, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
