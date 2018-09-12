require_relative '../config/environment'

Playlist.destroy_all
User.destroy_all
Follow.destroy_all
Song.destroy_all

# Playlist.create(name: "90s", user_id:1)
# User.create(name: "Andrew")
# User.create(name: "Jordan")
# User.create(name: "Nick")
# follow_1 = Follow.create()
# follow_2 = Follow.create()
# User.all.first.follows << follow_1
# Playlist.all.first.follows << follow_1



client_id = 'e52b827036954bfbb37666dc62aebd80'
client_secret = '3d61a827a64c438fb9fbf806742d24da'

RSpotify.authenticate(client_id, client_secret)

drake = RSpotify::Artist.search('Drake')

andrew = User.create(name: "Andrew")
User.create(name: "Nick")
User.create(name: "John")
User.create(name: "Graham")
User.create(name: "Kim")

Song.add_song('Hotline Bling')
Song.add_song("God's Plan")

playlist1 = Playlist.create(name: "Andrew's Playlist", user_id: User.all.first.id)






# in_my_feelings = RSpotify::Song.search('In my feelings')






binding.pry


puts "HELLO WORLD"
