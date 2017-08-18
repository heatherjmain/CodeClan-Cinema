require_relative("../db/sql_runner")

class Film

  attr_accessor(:title, :price)
  attr_reader(:id)

  def initialize( film )
    @id = film["id"].to_i
    @title = film[:title]
    @price = film[:price]
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film["id"].to_i
  end

  def self.map(rows)
    return rows.map {|row| Film.new(row)}
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    return Film.map(films)
  end



end
