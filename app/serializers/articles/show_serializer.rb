class Articles::ShowSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper

  attributes :id, :title, :body, :category

  def body
    if current_user != nil && current_user.role != nil
      object.body
    else
      truncate(object.body, length: 350)
    end
  end

end

