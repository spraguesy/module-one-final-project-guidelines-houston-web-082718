class Playlist < ActiveRecord::Base

    has_many :playlist_songs
    has_many :songs, through: :playlist_songs
    belongs_to :user

    has_many :follows
    has_many :followers
    has_many :users, :as => :followers, through: :follows

    alias_attribute :followers, :users

    def add_songs_to_playlist(song)
        PlaylistSong.create(song_id:song.id, playlist_id: self.id)
    end 

    
end