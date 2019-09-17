#####
# Users input
#####

puts 'Enter below day, month and year: '
day = gets.to_i
month = gets.to_i
year = gets.to_i

months_days = [31, 28, 31, 30 , 31, 30 , 31, 31, 30, 31, 30, 31]

#####
# Setting calculated_days to 1 if entered year is a leap year.
#####

leap_year = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
calculated_days = 0
calculated_days += 1 if leap_year && month > 2

#####
# Calculating days in previous months
#####

month - 1 == 0 ? calculated_days += day : calculated_days += months_days.take(month-1).reduce(:+) + day

#####
# Output result
#####

print "This day is #{calculated_days} in the year."
