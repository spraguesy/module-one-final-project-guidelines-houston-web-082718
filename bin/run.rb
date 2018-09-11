require_relative '../config/environment'



puts "HELLO WORLD"

client_id = 'e52b827036954bfbb37666dc62aebd80'
client_secret = '3d61a827a64c438fb9fbf806742d24da'

RSpotify.authenticate(client_id, client_secret)

me = RSpotify::User.find('y80ck1c8ljgnpwvj1au735a11')

tracks = RSpotify::Track.search('Nice for what')
# artists = RSpotify::Artist.search(limit: 10)

featured = RSpotify::Playlist.browse_featured

binding.pry
