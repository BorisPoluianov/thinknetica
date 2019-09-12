print "Enter a: "
a = Integer(gets)
print "Enter b: "
b = Integer(gets)
print "Enter c: "
c = Integer(gets)


d = b ** 2 - 4 * a * c

if d < 0 
  puts "Discriminant = #{d}. Has no roots."
elsif d == 0
  x = ( -b + Math.sqrt(d) ) / ( 2 * a )
  puts "Discriminant = #{d}. Has one root: x = #{x}"
elsif d > 0 
  x_1 = ( -b + Math.sqrt(d) ) / ( 2 * a )
  x_2 = ( -b - Math.sqrt(d) ) / ( 2 * a )
  puts "Discriminant = #{d}. Has x_1 = #{x_1} & x_2 = #{x_2}"
end
