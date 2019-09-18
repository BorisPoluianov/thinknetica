basket = {}
grand_total = 0

loop do

  puts 'Enter below product name, price and quantity: '
  product_name = gets.chomp.downcase.to_sym

  break if product_name == :stop

  entered_price = gets.to_f
  entered_quantity = gets.to_f

  basket[product_name] = {price: entered_price, quantity: entered_quantity}

end

puts "\nYour basket have: "

basket.each do |product_name, product_info|
  
  total_per_item = product_info[:price] * product_info[:quantity]
  puts "#{product_name.capitalize} - $#{product_info[:price]} - " \
    "quantity: #{product_info[:quantity]} - " \
    "total per item: $#{total_per_item}."
  grand_total += total_per_item

end

50.times { print '=' }
puts "\nGrand total: $#{grand_total}"
