class User < ActiveRecord::Base

   has_many :follows
   has_many :playlists, through: :follows
   has_many :plays
   has_many :songs, through: :plays 

   def self.play_song(song)
    
   end 

end