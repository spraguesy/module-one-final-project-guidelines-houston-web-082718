require_relative '../config/environment'


Playlist.create(name: "90s", user_id:1)
User.create(name: "Andrew")
User.create(name: "Jordan")
User.create(name: "Nick")
follow_1 = Follow.create()
follow_2 = Follow.create()
User.all.first.follows << follow_1
Playlist.all.first.follows << follow_1


binding.pry


puts "HELLO WORLD"
