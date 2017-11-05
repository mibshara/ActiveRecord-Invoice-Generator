load 'ar.rb'

def currency amount
  sprintf("$%.2f",amount)
end

# Customers with new orders
customers_with_orders = Customer.includes(:orders).where(orders: { status: 'new' })

# looping by the customers
customers_with_orders.each { |customer|

  # looping by the order
  customer.orders.each { |new_order|

    # putting customer details
    puts "Invoice for #{customer.first_name} #{customer.last_name}"
    puts "#{customer.address}"
    puts "#{customer.city} , #{customer.province.name}"

    puts""

    subtotal = 0


    # looping through the line_items
    new_order.line_items.each { |line_item|

      item_name =   line_item.product.name
      item_price =  line_item.price
      item_quantity = line_item.quantity
      item_total =   item_quantity*item_price

      # putting line_item details
      puts "#{item_name} #{'.' * (35 - item_name.length) } #{item_quantity} x #{currency(item_price)} = #{currency(item_total)}"

      subtotal += item_total

    }

    pst = subtotal * new_order.pst_rate
    gst = subtotal * new_order.gst_rate
    hst = subtotal * new_order.hst_rate
    total = subtotal + pst + gst + hst

    # putting the total iinvoice details
    puts ""

    puts "Sub Total     :  #{currency(subtotal)}"

    puts "PST (#{new_order.pst_rate.round(2) * 100}%) :  #{currency(pst)}" unless pst.zero?
    puts "GST (#{new_order.gst_rate.round(2) * 100}%) :  #{currency(gst)}" unless gst.zero?
    puts "HST (#{new_order.hst_rate.round(2) * 100}%) :  #{currency(hst)}" unless hst.zero?

    puts "Grand Total:  #{currency(total)}"
    puts "\n\n"

  }

}
