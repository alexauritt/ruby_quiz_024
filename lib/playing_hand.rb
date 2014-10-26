class PlayingHand
	attr_reader :card
	def method_missing(meth, *args)
		if Numeric.respond_to?(meth) && args.length == 1 && args.first.kind_of?(PlayingHand)
			self.hand_ranking.send(meth, args.first.hand_ranking)
		else
			super
		end
	end

	def ==(other_playing_hand)
		self.hand_ranking == other_playing_hand.hand_ranking
	end

	def hand_ranking
		raise "attempt to call hand_ranking on abstract class"
	end
end





