module Cardser
	module Hands
		class StraightFlush < PlayingHand
		  def hand_ranking; 8 end

		  def sort_cards_by_prominence!
		    @cards.sort! {|a,b| b.value <=> a.value }
		  end

		  def valid?
		    straight? and flush?
		  end
		end
	end
end