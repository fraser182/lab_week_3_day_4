require_relative ('../db/sql_runner.rb')
require_relative ('./artist.rb')


class Album

  attr_reader :id
  attr_accessor :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    sql = "INSERT INTO albums
    (
      title,
      genre,
      artist_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE albums SET
    (
      title,
      genre,
      artist_id
    )
    =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

# in pry Album.find(45) (value being passed changes)

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)

    order_hash = result.first
    order = Album.new(order_hash)
    return order
  end

  # in pry Album.all (gives all album details for each album)

  def self.all()
    sql = "SELECT * FROM albums"
    orders = SqlRunner.run(sql)
    return orders.map { |order| Album.new(order)}
  end


end
