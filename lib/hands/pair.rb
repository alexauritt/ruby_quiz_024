class Pair < PlayingHand
	def hand_ranking; 1 end

	def sort_cards_by_prominence!
		@cards.sort! {|a,b| b.value <=> a.value }

		card_values = cards.map {|c| c.value }
		grouped_values = card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
	
		pair_values = grouped_values.select {|card_value, count| count == 2}.keys

		sorted_card_list = []
		pair_values.each do |value|
			sorted_card_list << @cards.select { |card| card.value == value }			
		end

		sorted_card_list.flatten!
		remaining = @cards - sorted_card_list
		remaining.sort! {|a,b| b.value <=> a.value }
		
		sorted_card_list << remaining
		@cards = sorted_card_list.flatten
	end

end
