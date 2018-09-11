class Follower < ActiveRecod::Base

    belongs_to :user
    belongs_to :playlist
    
end