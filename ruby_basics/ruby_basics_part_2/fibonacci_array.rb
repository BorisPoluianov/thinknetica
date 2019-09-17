fibonacci_array = [0, 1]
num_to_add = 1
LIMIT = 100

while num_to_add  < LIMIT
  fibonacci_array << num_to_add
  num_to_add = fibonacci_array[-1] + fibonacci_array[-2]
end

puts fibonacci_array
