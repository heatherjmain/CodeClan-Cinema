require_relative("../db/sql_runner")

class Ticket

  attr_reader(:id, :customer_id, :film_id)

  def initialize( ticket )
    @id = ticket["id"].to_i
    @customer_id = ticket["customer_id"].to_i
    @film_id = ticket["film_id"].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def self.map(rows)
    return rows.map {|row| Ticket.new(row)}
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    return Ticket.map(tickets)
  end


def delete()
  sql = "DELETE FROM tickets WHERE id = $1;"
  SqlRunner.run(sql, [@id])
end

def self.delete_all()
  sql = "DELETE FROM tickets;"
  SqlRunner.run(sql, [])
end

end
