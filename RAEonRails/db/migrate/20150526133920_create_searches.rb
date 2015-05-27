class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :word_search

      t.timestamps null: false
    end
  end
end
