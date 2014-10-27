class FourOfAKind < PlayingHand
	def hand_ranking; 7 end
	
	def sort_cards_by_prominence!
		@cards.sort! {|a,b| Card::VALUES.index(b[0]) <=> Card::VALUES.index(a[0]) }
		unless value_of(@cards.first) == value_of(@cards[1])
			@cards.push @cards.shift
		end
	end
end
