class FlightSerializer < ActiveModel::Serializer
  attributes :id, :ArrivalTime, :DepartTime, :Price, :Duration, :OriginPlace, :DestinationPlace
  has_many :userflights
  has_many :users, through: :userflights
end
