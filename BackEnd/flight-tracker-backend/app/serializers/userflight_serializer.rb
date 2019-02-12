class UserflightSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :flight_id
  belongs_to :user
  belongs_to :flight
end
