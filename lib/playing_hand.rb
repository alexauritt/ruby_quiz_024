class PlayingHand
	def initialize(cards = [])
		@cards = cards
	end

	def >(other_playing_hand)
		unless other_playing_hand.kind_of?(PlayingHand)
			raise ArgumentError, "Excpected instance of playing hand but received: #{other_playing_hand}" 
		end
		
		self.hand_ranking > other_playing_hand.hand_ranking
	end

	private

	def hand_ranking
		raise "attempt to call hand_ranking on abstract class"
	end
end





