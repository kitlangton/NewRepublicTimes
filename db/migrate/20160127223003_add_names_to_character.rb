class AddNamesToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :prefix, :string
    add_column :characters, :first, :string
    add_column :characters, :middle, :string
    add_column :characters, :last, :string
  end
end
