class User < ApplicationRecord
  has_many :userflights
  has_many :flights, through: :userflights
end
