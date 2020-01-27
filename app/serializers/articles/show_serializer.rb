class Articles::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  def body
    binding.pry
  end

end