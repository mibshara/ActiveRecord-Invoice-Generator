load 'ar.rb'

customers = Customer.all

customers.each { |i|
  person = i.first_name.split(" ")

  i.update(last_name: "#{person[1]}", first_name: "#{person[0]}")
  i.save
}
