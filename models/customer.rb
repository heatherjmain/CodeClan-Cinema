require_relative("../db/sql_runner")

class Customer

  attr_accessor(:name, :funds)
  attr_reader(:id)

  def initialize ( customer )
    @id = customer["id"].to_i
    @name = customer[:name]
    @funds = customer[:funds]
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  def self.map(rows)
    return rows.map {|row| Customer.new(row)}
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = Customer.map(customers)
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE ID = $3;"
    values = [@name, @funds, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end

  def films_booked()
    sql = "SELECT * FROM films
    INNER JOIN tickets ON films.id = tickets.film_id
    WHERE customer_id = $1;"
    values = [@id]
    hash = SqlRunner.run(sql, values)
    films = hash.map {|hash| hash["title"]}
    # films = Customer.map(hash) ?????????
    return films
  end

  def buy_ticket(film)
    if @funds >= film.price
      @funds -= film.price
      self.update()

      ticket = Ticket.new({
        "customer_id" => @id,
        "film_id" => film.id
        })
      ticket.save()

      puts "Enjoy the film"

    else
      puts "I'm sorry, you do not have enough money!"
    end
  end

  def how_many_tickets_purchased()
    return films_booked.length()
  end



end
