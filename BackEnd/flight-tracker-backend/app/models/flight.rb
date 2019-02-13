class Flight < ApplicationRecord
  has_many :userflights
  has_many :users, through: :userflights

  def self.getsessionkey(url)
     thekey = url.split('/').last
     thekey
  end
end
