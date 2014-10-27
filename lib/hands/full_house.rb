class FullHouse < PlayingHand
	def hand_ranking; 6 end
	
	def sort_cards_by_prominence!
		@cards.sort! {|a,b| b.value <=> a.value }
		unless (@cards[0].value == @cards[1].value) && 
			(@cards[1].value == @cards[2].value)
			@cards.push(@cards.shift)
			@cards.push(@cards.shift)
		end
	end

end
