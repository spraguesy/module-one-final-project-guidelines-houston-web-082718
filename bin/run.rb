require_relative '../config/environment'

Playlist.destroy_all
User.destroy_all
Follow.destroy_all
Song.destroy_all
Artist.destroy_all
Play.destroy_all

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
Song.add_song("In My Feelings")
Song.add_song("Get It Together")
Song.add_song("One Dance")

Song.add_song('Someone Like You')
Song.add_song('Hello')
Song.add_song('Rolling In the Deep')
Song.add_song('Set Fire to the Rain')
Song.add_song('Daydreamer')

Song.add_song('Delicate')
Song.add_song('Shake it Off')
Song.add_song('Look What You Made Me Do')
Song.add_song('End Game')


Playlist.create(name: "Andrew's Drake Playlist", user_id: User.first.id)
Playlist.create(name: "Andrew's Adele Playlist", user_id: User.first.id)
Playlist.create(name: "Andrew's TSwift Playlist", user_id: User.first.id)
Playlist.create(name: "Nick's Drake Playlist", user_id: User.second.id)


drake_songs = Artist.find("3TVXtAsR1Inumwj472S9r4").songs
adele_songs = Artist.find("4dpARuHxo51G3z768sgnrY").songs
tSwift_songs = Artist.find("06HL4z0CvFAxyc27GXpf02").songs


drake_songs.each do |song|
    Playlist.first.add_song_to_playlist(song)
    Playlist.fourth.add_song_to_playlist(song)
end

adele_songs.each do |song|
    Playlist.second.add_song_to_playlist(song)
end

tSwift_songs.each do |song|
    Playlist.third.add_song_to_playlist(song)
end

User.first.follow_playlist(Playlist.fourth)
# User.second.follow_playlist(Playlist.first)
User.third.follow_playlist(Playlist.first)
User.fourth.follow_playlist(Playlist.first)
User.fifth.follow_playlist(Playlist.first)

User.first.play_song(Song.all.first)
User.first.play_song(Song.all.second)
User.first.play_song(Song.all.third)
User.first.play_song(Song.all.third)

User.second.play_song(Song.all.first)
User.second.play_song(Song.all.third)








# in_my_feelings = RSpotify::Song.search('In my feelings')






binding.pry


puts "HELLO WORLD"
