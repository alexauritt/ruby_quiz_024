class FullHouse < PlayingHand
	def hand_ranking; 6 end
	
	def sort_cards_by_prominence!
		@cards.sort! {|a,b| Card::VALUES.index(b[0]) <=> Card::VALUES.index(a[0]) }
		unless (value_of(@cards[0]) == value_of(@cards[1])) && 
			(value_of(@cards[1]) == value_of(@cards[2]))
			@cards.push(@cards.shift)
			@cards.push(@cards.shift)
		end
	end

end
