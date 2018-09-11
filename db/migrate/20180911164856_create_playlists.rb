class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.integer :num_followers
      t.belongs_to :user
    end
  end
end
