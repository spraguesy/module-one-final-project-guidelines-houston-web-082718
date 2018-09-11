class Song < ActiveRecord::Base

    has_many :playlist_songs
    has_many :playlists, through: :playlist_songs
    has_many :artists
    has_many :users, through: :plays

    def self.add_song(name)
        new_song_array = RSpotify::Track.search(name, limit:1)
        new_song = new_song_array.first
        self.create(name: new_song.name, popularity: new_song.popularity, danceability: new_song.audio_features.danceability)

    end

end