class Articles::IndexSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper

  attributes :id, :title, :body, :category

  def body
    if instance_options[:role] == 'publisher'
      object.body
    else
      truncate(object.body, length: 75)
    end
  end

end