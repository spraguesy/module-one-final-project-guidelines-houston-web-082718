class User < ActiveRecord::Base

   has_many :follows
   has_many :playlists, through: :follows
   has_many :plays
   has_many :songs, through: :plays 

   def play_song(song)
    Play.create(user_id:self.id, song_id:song.id)
    # puts "Mmmbop, ba duba dop
    # Ba du bop, ba duba dop
    # Ba du bop, ba duba dop
    # Ba du, yeah!!!"
   end 

   def follow_playlist(playlist)
    Follow.create(user_id:self.id, playlist_id:playlist.id)
   end 

end