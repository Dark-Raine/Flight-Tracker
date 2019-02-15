class UserSerializer < ActiveModel::Serializer
  # has_many :userflights
  has_many :flights, through: :userflights
  attributes :id, :username
    class FlightSerializer < ActiveModel::Serializer
      attributes :id, :ArrivalTime, :DepartTime,
      :Price, :Duration, :OriginPlace, :DestinationPlace
    end
end
