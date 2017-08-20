require_relative("../db/sql_runner")

class Screening

  attr_accessor("film_id", "start_time")
  attr_reader("id")

  def initialize( screening )
    @id = screening["id"].to_i,
    @film_id = screening["film_id"].to_i,
    @start_time = screening["start_time"]
  end

  def save()
    sql = "INSERT INTO screenings (film_id, start_time) VALUES ($1, $2) RETURNING id;"
    values = [@film_id, @start_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening["id"].to_i
  end

  def self.map(rows)
    return rows.map {|row| Screening.new(row)}
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    screening = SqlRunner.run(sql, values)
    return Screening.map(screening)
  end

  def update()
    sql = "UPDATE screenings SET (film_id, start_time) = ($1, $2) WHERE id = $3;"
    values = [@film_id, @start_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql, [])
  end



end
