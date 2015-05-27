class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :definition
      t.references :word, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
