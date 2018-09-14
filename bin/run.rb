require_relative '../config/environment'

Playlist.destroy_all
User.destroy_all
Follow.destroy_all
Song.destroy_all
Artist.destroy_all
Play.destroy_all
PlaylistSong.destroy_all


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

# User.first.follow_playlist(Playlist.fourth)
User.third.follow_playlist(Playlist.fourth)
User.third.follow_playlist(Playlist.first)
User.fourth.follow_playlist(Playlist.first)
User.fifth.follow_playlist(Playlist.first)

User.first.play_song(Song.all.first)
User.first.play_song(Song.all.second)
User.first.play_song(Song.all.third)
User.first.play_song(Song.all.third)

User.second.play_song(Song.all.first)
User.second.play_song(Song.all.third)

def help
    help = <<-HELP 
    What do you want to do?

        1 - Play a song
        2 - Display your playlists
        3 - Find most popular playlist I don't follow
        4 - Find my most danceable playlist
        5 - Find songs I haven't listened to
        6 - Find my most played songs
        7 - Exit
    HELP

    puts help
end

def cli_play_song (user, song_name, song_artist)
    puts "\n\n*********************\n\n"

    found_song = Song.find_by(name: song_name)
    if found_song == nil
        added_song = Song.add_song(song_name)
        found_song = added_song
        user.play_song(found_song)
        if added_song.artist.name != song_artist
            cant_find
            puts "\n\n*********************\n\n"

            return
        end
        # if added_song =! nil
        #     found_song = Song.find_by(name: song_name)
        #     user.play_song(found_song)
        # else
        #     puts "\n\n*********************\n\n"

        #     puts "Ahh I can't find that song"
        #     puts "\n\n*********************\n\n"

        #     # cli_play_song
        # end 
    else
        user.play_song(found_song)
    end

    
    puts "\n\nNow playing #{song_name} by #{song_artist}.\n\n"


    fetcher = Lyricfy::Fetcher.new(:wikia)
    song = fetcher.search "#{song_artist}", "#{song_name}"
    song.lines.each do |line|
        puts line
        # sleep(0.3)
    end
    puts "\n\n*********************\n\n"

    print "That was my jam. Do you want to add that song to a playlist? (yes/no)\n "

    add_to_playist = gets.downcase.chomp

    if add_to_playist == 'y' || add_to_playist == 'yes'

        if user.my_playlists.length > 0
            puts "Here is a list of your playlists."
            
            user.my_playlists.each do |playlist|
                puts "#{user.my_playlists.index(playlist)+1} - #{playlist.name}"
            end
            print 'Which playlist would you like to add it to? '
    
            playlist_number = gets.chomp
    
    
    
            user.my_playlists[playlist_number.to_i-1].add_song_to_playlist(found_song)


            
        else
            puts "\n\n*********************\n\n"

            puts "You don't own any playlists."

            puts "\n\n*********************\n\n"

        end


        
    end

    puts "\n\n*********************\n\n"
end

def display_playlists (user)
    puts "\n\n*********************\n\n"
    puts "Here are your playlists.\n\n"
    my_playlists = user.all_playlists
    my_playlists.each do |playlist|

        if user.owns?(playlist)
            puts "#{my_playlists.index(playlist)+1}. - #{playlist.name} (owner) #{playlist.id}"
            print_playlist_songs(playlist)
        else
            puts "#{my_playlists.index(playlist)+1}. - #{playlist.name} (follower)#{playlist.id}"
            print_playlist_songs(playlist)
        end
        puts "\t"
    end
    puts "\n\n*********************\n\n"
    sleep(3)
end

def print_playlist_songs (playlist)
    playlist.songs.each do |song|
        puts "\t#{playlist.songs.index(song)+1}. #{song.artist.name} - #{song.name}"
    end
end

def most_pop_list_no_follow(user)
    puts "\n\n*********************\n\n"
    puts "You don't follow #{user.find_new_popular_playlist.name}. It has #{user.find_new_popular_playlist.followers.size} #{user.find_new_popular_playlist.followers.size > 1 ? 'followers.' : 'follower.'}\n\nHere are the songs.\n\n"

    user.find_new_popular_playlist.songs.each do |song|
        puts "#{user.find_new_popular_playlist.songs.index(song)+1}. - #{song.name}"
    end
    
    puts "\n\n*********************\n\n"
end

def cli_most_danceable_list (user)
    puts "\n\n*********************\n\n"

    md = user.most_danceable
    puts "'#{md.name}' is your most danceable with #{(md.average_danceability*100).to_i}% danceability.\n\nNo one is watching..."
    puts "\n\n*********************\n\n"
    sleep(5)
end

def songs_no_listen (user)

    puts "\n\n*********************\n\n"


    display_playlists(user)

    print "Which playlist do you want to see the songs you haven't listened to on? "

    playlist_num = gets.chomp

    not_listened_to = user.songs_not_listened_to_from(user.all_playlists[playlist_num.to_i-1])
    
    puts "Here are the song's you haven't listened to on this playlist:\n"
    not_listened_to.each do |song|
        puts "#{not_listened_to.index(song)+1}. #{song.artist.name} - #{song.name} "
    end

    puts "\n\n*********************\n\n"


end

def cant_find
    print "Sorry, I can't find what you are looking for" 
end

def cli_most_played_songs (user)
    puts "\n\n*********************\n\n"
    binding.pry
    songs = user.most_played_songs
    if (songs.length < 5) && (songs.length > 0)
        songs.length.times do |index|
            puts "#{index+1}. #{songs[index][:song].name} by #{songs[index][:song].artist.name} - Listened #{songs[index][:count]} #{songs[index][:count]>1 ? 'times.' : 'time.'}"
        end 
    elsif songs.length > 5
        5.times do |index|
            puts "#{index+1}. #{songs[index][:song].name} By #{songs[index][:song].artist.name} - Listened #{songs[index][:count]} times."
        end 
    else
        puts "You haven't played any songs."
    end 
    puts "\n*********************\n\n"
end

def end_program
    puts "\n\n*********************\n\n"    
    print "Bye Felicia"    
    puts "\n\n*********************\n\n"    
    
end


def run 
    puts "\n\n*********************\n\n"    
    print "Welcome to our Spotify Project.\nEnter your Username: "
    username = gets.capitalize.strip
    current_user = User.find_by(name: username)
    if current_user == nil
        puts "User not found. Do you want to create a new User? (y/n)"
        input = gets.downcase.chomp
        if input == 'y' || input == 'yes'
            puts "Created new user."
            current_user = User.create(name: username)    
        else
            run
        end

        
    end
    puts "\n\n"
    puts "Hey #{current_user.name}.\n\n"
    input = ""
    while input
        help
        current_user = User.find_by(name: username)
        input = gets.chomp
        case input
        when '1'
            print "What is the song's name? "
            song_name = gets.chomp.strip
            print "Who is the Artist? "
            song_artist = gets.chomp.strip
            cli_play_song(current_user, song_name, song_artist)
        when '2'
            display_playlists(current_user)
        when '3'
            most_pop_list_no_follow(current_user)
        when '4'
            cli_most_danceable_list(current_user)
        when '5'
            songs_no_listen(current_user)
        when '6'
            cli_most_played_songs(current_user)
        when '7'
            end_program
            break
        else
            help
        end
    end
end

run

