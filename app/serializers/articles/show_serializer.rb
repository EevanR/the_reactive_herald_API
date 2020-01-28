class Articles::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :body, :image

  def image
    if object.image.attachment == nil
      object.image = nil
    else
      if Rails.env.test?
        rails_blob_url(object.image, only_path: true)
      else
        object.image.service_url(expires_in: 1.hours, disposition: 'inline')
      end
    end
  end
end