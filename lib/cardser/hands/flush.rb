module Cardser
	module Hands
		class Flush < PlayingHand 
		  def hand_ranking; 5 end
		  def sort_cards_by_prominence!
		    @cards.sort! {|a,b| b.value <=> a.value }
		  end

		  def valid?
		    flush?
		  end
		end
	end
end