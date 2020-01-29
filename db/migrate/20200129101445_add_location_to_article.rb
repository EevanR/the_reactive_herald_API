class AddLocationToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :location, :string, default: "All"
  end
end
