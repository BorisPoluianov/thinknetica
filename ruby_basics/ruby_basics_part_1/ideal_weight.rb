print 'What is your name? '
name = gets.chomp.capitalize
print 'What is your height (in cm)? '
height = gets.to_i

if height - 110 > 0 
  puts "Dear #{name}, your ideal weight is #{ height - 110 } kg."
else
  puts "Dear #{name}, your weight is already ideal. Go eat some bacon:)"
end
