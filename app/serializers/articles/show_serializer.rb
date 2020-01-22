class Articles::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end