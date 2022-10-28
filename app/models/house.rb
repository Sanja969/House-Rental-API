class House < ApplicationRecord
  has_many :reservations, foreign_key: 'house_id'
  validates :name, presence: true, length: { maximum: 250 }
  validates :image, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
