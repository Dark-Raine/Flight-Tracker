class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :userflights
  has_many :flights, through: :userflights
    class FlightSerializer < ActiveModel::Serializer
      attributes :id, :booking_url, :OutboundDate,
      :InboundDate, :Price, :Duration, :OriginPlace,
      :DestinationPlace
    end
end
