class Users::ShowSerializer < ActiveModel::Serializer
  attributes :id, :email, :role
end