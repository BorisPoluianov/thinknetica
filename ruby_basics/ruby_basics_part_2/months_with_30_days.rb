months = {
  'january': 31,
  'february': [28, 29],
  'march': 31,
  'april': 30,
  'may': 31,
  'june': 30,
  'july': 31,
  'august': 31,
  'september': 30,
  'october': 31,
  'november': 30,
  'december': 31
}

months.each { |month,days| puts "There are 30 days in #{month.capitalize}." if days == 30 }
