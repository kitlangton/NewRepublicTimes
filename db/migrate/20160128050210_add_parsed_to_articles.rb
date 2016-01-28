class AddParsedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :processed, :boolean, default: false
  end
end
