class Straight < PlayingHand
	def hand_ranking; 4 end

	def sort_cards_by_prominence!
		@cards.sort! {|a,b| Card::VALUES.index(b[0]) <=> Card::VALUES.index(a[0]) }
	end
end
