load 'ar.rb'

customers = Array.new

(1..3).each { |province_id|
  customers << Customer.where(:province_id == province_id).last
}

# Creating an array with all available product ids
products_array = (155..231).to_a

# Each order should involve at least four line items. (Use different products for each customer.)
customers.each do |customer|
  order = customer.orders.build

# Ensure that you set the status of all orders to ‘new’
  order.status="new"

# nsure that you backup the pst, gst and hst rates from the customer’s province into the appropriate properties of the order
  order.gst_rate = customer.province.gst
  order.pst_rate = customer.province.pst
  order.hst_rate = customer.province.hst

# Saving orders
  order.save

# Having four line_items for each order
  4.times {

# Ensure that each line item is associated with an order by way of its foreign key
  line_item = order.line_items.build

# Ensure that each line item has a set quantity.
  line_item.quantity = rand(1..15)

# Getting a product randomly
  product_index = rand(products_array.size)

  current_product = products_array[product_index]

  line_item.product = current_product

# Ensure that a backup of the associated product price is saved in each line item.
  line_item.price = current_product.price

  line_item.save

  }

end
