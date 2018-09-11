class ChangeArtistIdFromArtists < ActiveRecord::Migration[5.0]
  def change
    change_column :artists, :id, :string
  end
end
