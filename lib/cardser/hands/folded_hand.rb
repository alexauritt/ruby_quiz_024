module Cardser
	module Hands
		class FoldedHand < PlayingHand
		  def hand_ranking; -1 end
		end
	end
end
