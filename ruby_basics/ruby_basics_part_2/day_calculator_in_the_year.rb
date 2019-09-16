#####
# Users input
#####

puts 'Enter below day, month and year: '
day = gets.to_i
month = gets.to_i
year = gets.to_i

months_days = [ 31, 28, 31, 30 , 31, 30 , 31, 31, 30, 31, 30, 31]

#####
# Setting calculated_days to 1 if entered year is a leap year.
#####

if month > 2 && year % 4 == 0
  calculated_days = 1
elsif month > 2 && year % 4 == 0 && year % 100 > 0
  calculated_days = 1
elsif month > 2 && year % 4 == 0 && year % 100 == 0 && year % 400 == 0
  calculated_days = 1 
else
  calculated_days = 0
end

#####
# Calculating days in previous months
#####

months_days.take(month-1).each { |i| calculated_days += i }

#####
# Output result
#####

print "This day is #{calculated_days + day} in the year."
