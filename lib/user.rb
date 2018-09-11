class User < ActiveRecord::Base


   has_many :playlists
   has_many :followers, through: :playlists
   has_many :plays
   has_many :songs, through: :plays 

end