require ("pry")
require_relative('../models/artist.rb')
require_relative('../models/album.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new(
  {
    'name' => 'Linkin Park'
  }
)

artist1.save

artist2 = Artist.new(
  {
    'name' => 'Parkway Drive'
  }
)

artist2.save

album1 = Album.new(
  {
    'title' => 'Hybrid Theory',
    'genre' => 'Nu-metal',
    'artist_id' => "#{artist1.id}"
  }
)

album1.save

album2 = Album.new(
  {
    'title' => 'Meteora',
    'genre' => 'Nu-metal',
    'artist_id' => "#{artist1.id}"
  }
)

album2.save

album3 = Album.new(
  {
    'title' => 'Deep Blue',
    'genre' => 'Hardcore',
    'artist_id' => "#{artist2.id}"
  }
)

album3.save

album4 = Album.new(
  {
    'title' => 'Ire',
    'genre' => 'Hardcore',
    'artist_id' => "#{artist2.id}"
  }
)

album4.save

# album4.delete
# album2.genre = 'Post-punk'
# album2.update

# music = albums.find(20)
binding.pry
nil
