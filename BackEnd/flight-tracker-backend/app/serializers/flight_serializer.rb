class FlightSerializer < ActiveModel::Serializer
  attributes :id, :booking_url, :OutboundDate, :InboundDate, :Price, :Duration, :OriginPlace, :DestinationPlace
  has_many :userflights
  has_many :users, through: :userflights
end
