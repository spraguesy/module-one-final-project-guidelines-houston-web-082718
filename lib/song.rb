class Song < ActiveRecord::Base

    has_many :playlist_songs
    has_many :playlists, through: :playlist_songs
    has_many :artists
    has_many :users, through: :plays

end