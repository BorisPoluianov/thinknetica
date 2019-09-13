puts 'Enter below a, b, c: '
a = gets.to_i
b = gets.to_i
c = gets.to_i


d = b ** 2 - 4 * a * c

root_of_d = Math.sqrt(d) unless d < 0

if d < 0 
  puts "Discriminant = #{d}. Has no roots."
elsif d == 0
  x = ( -b + root_of_d ) / ( 2 * a )
  puts "Discriminant = #{d}. Has one root: x = #{x}"
elsif d > 0 
  x_1 = ( -b + root_of_d ) / ( 2 * a )
  x_2 = ( -b - root_of_d ) / ( 2 * a )
  puts "Discriminant = #{d}. Has x_1 = #{x_1} & x_2 = #{x_2}"
end
