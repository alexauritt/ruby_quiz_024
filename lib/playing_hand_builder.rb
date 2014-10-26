require 'straight_flush'
require 'card'

class PlayingHandBuilder
	def self.build(cards)
		return StraightFlush.new(cards) if straight_flush?(cards)
		return FourOfAKind.new(cards) if four_kind?(cards)
	end

	private
	
		def self.four_kind?(cards)
			group_by_value(cards).select {|card_value, count| count == 4}.length > 0
		end

		def self.straight_flush?(cards)
			flush?(cards) && straight?(cards)
		end

		def self.flush?(cards)
			cards.map {|c| c[1] }.uniq.one?
		end

		def self.straight?(cards)
			sorted_indexes = cards.map {|c| Card::VALUES.find_index c[0] }.uniq.sort
			return true if sorted_indexes.size == 5 && (sorted_indexes.last - sorted_indexes.first == 4)
			return true if broadway_straight?(cards)
			false
		end

		def self.broadway_straight?(cards)
			sorted_indexes = cards.map {|c| Card::VALUES.find_index c[0] }.uniq.sort
			count = sorted_indexes.count
			top = sorted_indexes.last
			count >= 5 && sorted_indexes.first == 0 && top == 12 && sorted_indexes[count - 4] == 9
		end


		def self.group_by_value(cards)
			card_values = cards.map {|c| c[0] }
			card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
		end

end