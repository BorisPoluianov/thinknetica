basket = Hash.new
total = 0

loop do

  puts 'Enter below item, price per item, quantity: '
  item = gets.chomp.downcase.to_s

break if item == 'stop'

  price = gets.to_i
  quantity = gets.to_f

  basket[:"#{item}"] = { 
 
    'price': price, 
    'quantity': quantity 
 
  }

end

puts "\nYour basket have: "

basket.each do |key, value|

  puts "#{key.capitalize} - $#{value[:price]} - quantity: #{value[:quantity]} - total per item: $#{value[:price] * value[:quantity]}."
  total += value[:price] * value[:quantity]

end

50.times { print "=" }
puts "\nGrand total: $#{total}"
