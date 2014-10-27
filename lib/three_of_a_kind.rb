class ThreeOfAKind < PlayingHand
	def hand_ranking; 3 end

	def sort_cards_by_prominence!
		@cards.sort! {|a,b| Card::VALUES.index(b[0]) <=> Card::VALUES.index(a[0]) }

		card_values = cards.map {|c| c[0] }
		grouped_values = card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
	
		three_kind_value = grouped_values.select {|card_value, count| count == 3}.keys.first
		sorted_card_list = @cards.select { |card| card[0] == three_kind_value }
		remaining = @cards - sorted_card_list
		sorted_card_list << remaining.sort.reverse
		@cards = sorted_card_list.flatten
	end

end
