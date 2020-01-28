class Articles::ShowSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper

  attributes :id, :title, :body

  def body
    if current_user != nil 
      if current_user[:role] == 'subscriber'
      object.body
      else
        truncate(object.body, length: 350)
      end
    else
      truncate(object.body, length: 350)
    end
  end

end