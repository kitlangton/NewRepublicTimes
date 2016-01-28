class CreateOccurrences < ActiveRecord::Migration
  def change
    create_table :occurrences do |t|
      t.references :occurrable, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true
      t.string :occurrable_type

      t.timestamps null: false
    end
  end
end
