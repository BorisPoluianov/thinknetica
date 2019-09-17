alphabet = ('a'..'z').to_a
vowels_hash = {}

alphabet.each_with_index do |letter, index|
  if 'aeiouy'.include?(letter)
    vowels_hash[letter.to_sym] = index + 1
  end
end

puts vowels_hash
