fibonacci_array = Array.new(1,0)
num_to_add = 1
LIMIT = 100

while num_to_add  < LIMIT
  fibonacci_array << num_to_add
  num_to_add = fibonacci_array.last + fibonacci_array.last(2).first
end

puts fibonacci_array
