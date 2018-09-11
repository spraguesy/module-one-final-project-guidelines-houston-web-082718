class ChangeArtistIdFromSongs < ActiveRecord::Migration[5.0]
  def change
    change_column :songs, :artist_id, :string
  end
end
