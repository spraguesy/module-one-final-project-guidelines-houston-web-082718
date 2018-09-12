class Song < ActiveRecord::Base

    has_many :playlist_songs
    has_many :playlists, through: :playlist_songs
    belongs_to :artist
    has_many :plays
    has_many :users, through: :plays

    def self.add_song(name)
        new_song_array = RSpotify::Track.search(name, limit:1)
        new_song = new_song_array.first
        artist = new_song.artists.first
        self.create(name: new_song.name, popularity: new_song.popularity, danceability: new_song.audio_features.danceability, artist_id: artist.id)

        #create artist portion
        Artist.create_with(name: artist.name, popularity: artist.popularity).find_or_create_by(id: artist.id)
    end

end