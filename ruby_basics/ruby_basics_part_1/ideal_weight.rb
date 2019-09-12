print "What's your name? "
name = gets.chomp.capitalize!
print "What's your height (in cm)? "
height = gets.to_i

ideal_weight = height - 110

if ideal_weight > 0 
  puts "Dear #{name}, your ideal weight is #{ideal_weight} kg."
else
  puts "Dear #{name}, your weight is already ideal."
end
