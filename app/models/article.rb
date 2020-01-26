class Article < ApplicationRecord
  validates_presence_of :title, :body
  
  belongs_to :journalist, class_name: 'User'
  belongs_to :publisher, class_name: 'User', optional: true

  has_one_attached :image
end