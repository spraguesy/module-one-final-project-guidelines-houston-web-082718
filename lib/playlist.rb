class Playlist < ActiveRecord::Base

    has_many :playlist_songs
    has_many :songs, through: :playlist_songs
    belongs_to :user

    has_many :users :as => :followers
    has_many :followers

    
end