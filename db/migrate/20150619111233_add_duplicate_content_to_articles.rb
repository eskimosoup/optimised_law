class AddDuplicateContentToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :duplicate_content, :boolean, default: true
  end
end
