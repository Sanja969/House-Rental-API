class Reservation < ApplicationRecord
  belongs_to :house, foreign_key: 'house_id'
  belongs_to :user, foreign_key: 'user_id'
  validates :city, :date, :user_id, :house_id, presence: true
end
