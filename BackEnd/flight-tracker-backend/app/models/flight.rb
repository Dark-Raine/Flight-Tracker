class Flight < ApplicationRecord
  has_many :userflights
  has_many :users, through: :userflights
end
