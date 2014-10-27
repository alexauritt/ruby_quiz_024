require 'card'

class StraightFlush < PlayingHand
	def hand_ranking; 8 end
	
	def sort_cards_by_prominence!
		@cards.sort! {|a,b| Card::VALUES.index(b[0]) <=> Card::VALUES.index(a[0]) }
	end
end