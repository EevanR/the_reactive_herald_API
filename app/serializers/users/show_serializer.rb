class Users::ShowSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :subscriber
end