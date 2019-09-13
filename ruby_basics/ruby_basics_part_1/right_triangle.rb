puts 'Enter bellow the sides of your triangle (a, b, c): '
a = gets.to_i
b = gets.to_i
c = gets.to_i

arr = [ a, b, c].sort

if arr[2] >= arr[0] + arr[1]
  puts 'Your triangle does not exist.'
elsif arr.uniq.size == 1
  puts 'Your triangle is equilateral.'
elsif arr.uniq.size == 2
  puts 'Your triangle is isosceles.'
elsif arr[2] ** 2 == arr[0] ** 2 + arr[1] ** 2 
  puts 'Your triangle is right.'
else
  puts 'Your triangle is typical.'
end

