class House < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }
  validates :image, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
