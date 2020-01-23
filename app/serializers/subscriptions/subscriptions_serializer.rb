class Subscriptions::CreateSerializer < ActiveModel::Serializer
  attributes :id, :email, :arrount_balance, :sources, :currency
end
