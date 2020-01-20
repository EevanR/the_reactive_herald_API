class Article < ApplicationRecord
  validates_presence_of :title, :body
  
  belongs_to :journalist, class_name: 'User'
end