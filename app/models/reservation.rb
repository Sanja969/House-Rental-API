class Reservation < ApplicationRecord
  belongs_to :hours, class_name: 'House', foreign_key: 'house_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end
