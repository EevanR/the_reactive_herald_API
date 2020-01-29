class TranslateArticles < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        Article.create_translation_table!({
                                         title: :string,
                                         body: :text
                                       }, {
                                         migrate_data: true,
                                         remove_source_columns: true
                                       })
      end
      dir.down do
        Article.drop_translation_table! migrate_data: true
      end
    end
  end
end
