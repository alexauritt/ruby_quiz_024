

results = HandsBuilder.build.map {|hand_string| Hand.new(hand_string) }.sort.reverse
results.each {|hand| puts hand.to_s}
