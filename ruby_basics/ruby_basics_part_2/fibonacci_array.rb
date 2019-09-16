fibonacci_array = Array.new
num_to_add = 1

while num_to_add  < 100
  fibonacci_array << num_to_add
  num_to_add = fibonacci_array.last + fibonacci_array.last(2)[0]
end

print fibonacci_array
