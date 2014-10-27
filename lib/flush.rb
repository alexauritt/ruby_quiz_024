class Flush < PlayingHand
	def hand_ranking; 5 end
	def sort_cards_by_prominence!
		@cards.sort! {|a,b| b[1] <=> a[1] }
			unless suit_of(@cards.first) == suit_of(@cards[1])
			@cards.push @cards.shift
		end
	end
end
