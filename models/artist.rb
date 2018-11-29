require_relative ('../db/sql_runner.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id   = options['id'].to_i() if options['id']
    @name = options['name']
  end

  def save()

    sql = "INSERT INTO artists
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values=[@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()

  end

  def update()
    sql = "UPDATE artists SET
    (
      name
    )
    =
    (
      $1
    )
    WHERE id = $2"
    values = [@name, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  # in pry, Artist.delete_all <- deletes everything in DB. then check with SELECT * FROM artists
  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end


  # in pry Artist.find(45) (value being passed changes)

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)

    order_hash = result.first
    order = Artist.new(order_hash)
    return order
  end

end
