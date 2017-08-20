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

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id =  $3"
    values = [@title, @price, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql, [])
  end

  def customers_viewing_film()
    sql = "SELECT * FROM customers
    INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1;"
    values = [@id]
    hash = SqlRunner.run(sql, values)
    customers = hash.map {|hash| hash["name"]}
    return customers
  end

  def number_of_viewers()
    return customers_viewing_film().length()
  end



end
