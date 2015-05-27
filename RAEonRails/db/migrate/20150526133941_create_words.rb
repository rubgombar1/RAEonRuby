class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.references :search, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
