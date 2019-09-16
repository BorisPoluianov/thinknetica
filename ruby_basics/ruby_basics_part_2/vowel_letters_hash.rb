alphabet = ('a'..'z').to_a
vowels_hash = Hash.new

alphabet.each do |letter|
  if 'aeiouy'.include?(letter)
    vowels_hash[letter] = alphabet.index(letter) + 1
  end
end

puts vowels_hash
