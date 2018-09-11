class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :popularity
      t.float :danceability
      t.belongs_to :artist
    end
  end
end
