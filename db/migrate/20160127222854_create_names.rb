class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :prefix
      t.string :first
      t.string :middle
      t.string :last
      t.references :character, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
