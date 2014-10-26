class PlayingHand
	attr_reader :card
	# comparator_list = ['<','>','<=','>=','!=']
	def method_missing(meth, *args)
		# puts "args #{meth.class} #{self.hand_ranking} #{args.first.hand_ranking}"
		# puts "does it #{comparator_list.include?(meth.to_s)}"
		# if !comparator_list.include?(meth.to_s)
		# 	puts "no found"
		# 	super
		# end
		# self.hand_ranking.meth args.first.hand_ranking
		# super
		# false
		self.hand_ranking.send(meth, args.first.hand_ranking)
		# self.hand_ranking.send(meth, args.first.hand_ranking)
	end

	def ==(other_playing_hand)
		self.hand_ranking == other_playing_hand.hand_ranking
	end

	# def !=(other_playing_hand)
	# 	self.hand_ranking != other_playing_hand.hand_ranking
	# end

	def hand_ranking
		raise "attempt to call hand_ranking on abstract class"
	end
end





