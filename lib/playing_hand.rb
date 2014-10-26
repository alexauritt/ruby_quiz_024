class PlayingHand
	def >(other_playing_hand)
		unless other_playing_hand.kind_of?(PlayingHand)
			raise ArgumentError, "Excpected instance of playing hand but received: #{other_playing_hand}" 
		end
		
		self.hand_ranking > other_playing_hand.hand_ranking
	end
	# attr_reader :card
	# def method_missing(meth, *args)
	# 	acceptable_comparison?(meth, *args) ? 
	# 		self.hand_ranking.send(meth, args.first.hand_ranking) :
	# 		super
	# end

	# def ==(other_playing_hand)
	# 	self.hand_ranking == other_playing_hand.hand_ranking
	# end

	# def !=(other_playing_hand)
	# 	self.hand_ranking != other_playing_hand.hand_ranking
	# end

	private
	# def acceptable_comparison?(meth_sym, *args)
	# 	[:>, :<, :>=, :<=].include?(meth_sym) &&
	# 		args.length == 1 && args.first.kind_of?(PlayingHand)
	# end

	def hand_ranking
		raise "attempt to call hand_ranking on abstract class"
	end
end





