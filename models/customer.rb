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




end
