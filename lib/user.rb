class User < ActiveRecord::Base

   has_many :follows
   has_many :playlists, through: :follows
   has_many :playlists
   has_many :plays
   has_many :songs, through: :plays 

   def play_song(song)
    Play.create(user_id:self.id, song_id:song.id)
   end 

   def follow_playlist(playlist)
    Follow.create(user_id:self.id, playlist_id:playlist.id)
   end 

   def follows?(playlist)
       playlist.followers.include?(self)
   end

   def owns?(playlist)
        (self.follows?(playlist) == false && (self.playlists.include?(playlist)))
   end 

   def find_new_popular_playlist #if I'm the owner of the most followed playlist, it will return my owned playlist
       all_playlists = Playlist.all
       most_followers = 0
       most_followed_playlist = nil
        all_playlists.each do |playlist|
            if(self.follows?(playlist) == false && self.owns?(playlist) == false && playlist.followers.size > most_followers)
                most_followed_playlist, most_followers = playlist, playlist.followers.size 
            end 
        end 
        most_followed_playlist
   end

   def songs_not_listened_to_from(playlist)
        songs = playlist.songs.select do|song|
            self.songs.include?(song) == false
        end 
        songs
   end

   def most_played_song
        most_played = {}
        self.songs.each do |song|     
            if(most_played[song])
                most_played[song] += 1
            else
                most_played[song] = 1
            end
        end
        most_played.key(most_played.values.max)
   end 

   def most_danceable
        most_dance = 0
        most_danceable = nil
        self.all_playlists.each do |play|
            if play.average_danceability > most_dance
                most_dance = play.average_danceability
                most_danceable = play
            end
        end
        most_danceable
   end

   def all_playlists
    playlist_array = []
    self.playlists.each do |play|
        playlist_array << play
    end

    self.follows.each do |follow|
        playlist_array << follow.playlist
     end

     playlist_array
   end

end