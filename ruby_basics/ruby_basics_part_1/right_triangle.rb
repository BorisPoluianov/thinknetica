print "Enter the first side of your triangle? "
a = Integer(gets)
print "Enter the second side of your triangle? "
b = Integer(gets)
print "Enter the last side of your triangle? "
c = Integer(gets)

if a == b && b == c
  puts "Your triangle is equilateral."
elsif a == b || b == c || c == a
  puts "Your triangle is isosceles."
elsif a ** 2 ==  b ** 2 + c ** 2 || 
      b ** 2 ==  a ** 2 + c ** 2 ||
      c ** 2 ==  a ** 2 + b ** 2 
  puts "Your triangle is right."
elsif a + b < c ||
      b + c < a ||
      c + a < b 
  puts "Your triangle does not exist."
else
  puts "Your triangle is typical."
end

