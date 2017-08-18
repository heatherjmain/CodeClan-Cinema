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



binding.pry
nil
