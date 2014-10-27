class PlayingHand
	attr_reader :cards

	def initialize(cards = [])
		@cards = cards
		sort_cards_by_prominence!
	end

	def >(other_playing_hand)
		unless other_playing_hand.kind_of?(PlayingHand)
			raise ArgumentError, "Excpected instance of playing hand but received: #{other_playing_hand}" 
		end
		
		if superior_hand_rank?(other_playing_hand)
			true
		elsif inferior_hand_rank?(other_playing_hand)
			false
		else
			superior_card_values?(other_playing_hand)
		end
	end

	def value_of(card)
		Card::VALUES.index(card[0])
	end

	def suit_of(card)
		card[1]
	end
	
	private

	def superior_hand_rank?(other_playing_hand)
		self.hand_ranking > other_playing_hand.hand_ranking
	end

	def inferior_hand_rank?(other_playing_hand)
		self.hand_ranking < other_playing_hand.hand_ranking
	end

	def superior_card_values?(other_playing_hand)
		5.times do |i|
			card_value = Card::VALUES.index(@cards[i][0])
			other_card_value = Card::VALUES.index(other_playing_hand.cards[i][0])
			return false if other_card_value > card_value
			return true if card_value > other_card_value
		end
		false
	end

	def hand_ranking
		raise "attempt to call hand_ranking on abstract class"
	end

	def sort_cards_by_prominence!
		# raise "attempt to call sort_cards_by_prominence! on abstract class"
	end
end





