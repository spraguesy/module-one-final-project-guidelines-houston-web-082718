class Playlist < ActiveRecord::Base

    has_many :playlist_songs
    has_many :songs, through: :playlist_songs
    belongs_to :user

    has_many :follows
    has_many :followers
    has_many :users, :as => :followers, through: :follows

    alias_attribute :followers, :users

    def add_song_to_playlist(song)

        # PlaylistSong.find_or_create_by(song_id: song.id, playlist_id: self.id)
        test_song = PlaylistSong.where(song_id: song.id, playlist_id: self.id)

        if test_song.length == 0
            PlaylistSong.create(song_id: song.id, playlist_id: self.id)
            puts "added to #{self.id}"
        end

    end 

    def average_danceability
        dance_array = self.songs.map{|song| song.danceability}
        dance_array.reduce(:+) / dance_array.length
    end

    
end