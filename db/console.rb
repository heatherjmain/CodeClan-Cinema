require("pry-byebug")

require_relative("../models/customer")
require_relative("../models/film")
require_relative("../models/ticket")



customer1 = Customer.new({name: "Tom", funds: 10})
customer1.save()
customer2 = Customer.new({name: "Maggie", funds: 30})
customer2.save()



film1 = Film.new({title: "Harry Potter", price: 7})
film1.save()
film2 = Film.new({title: "Die Hard", price: 5})
film2.save()
film3 = Film.new({title: "Frozen", price: 6})
film3.save()
film4 = Film.new({title: "IT", price: 8})
film4.save()

ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film2.id
  })
ticket1.save()

ticket2 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film1.id
  })
ticket2.save()

ticket3 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film4.id
  })
ticket3.save()

ticket4 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film3.id
  })
ticket4.save()

ticket5 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film2.id
  })
ticket5.save()

ticket6 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id
  })
ticket6.save()

ticket7 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film4.id
  })
ticket7.save()

ticket8 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film3.id
  })
ticket8.save()



binding.pry
nil
