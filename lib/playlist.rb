class Playlist < ActiveRecord::Base

    has_many :playlist_songs
    has_many :songs, through: :playlist_songs
    belongs_to :user

    has_many :follows
    has_many :followers
    has_many :users, :as => :followers, through: :follows

    alias_attribute :followers, :users

    def add_song_to_playlist(song)
        PlaylistSong.create(song_id:song.id, playlist_id: self.id)
    end 

    def average_danceability
        dance_array = self.songs.map{|song| song.danceability}
        dance_array.reduce(:+) / dance_array.length
    end

    
end