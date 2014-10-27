class Flush < PlayingHand
	def hand_ranking; 5 end
	def sort_cards_by_prominence!
		@cards.sort! {|a,b| b[0] <=> a[0] }
	end
end
