class RemoveNumFollowersFromPlaylists < ActiveRecord::Migration[5.0]
  def change
    remove_column :playlists, :followers, :integer
  end
end
