class AddCategoryToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :category, :integer, default: 5
  end
end
