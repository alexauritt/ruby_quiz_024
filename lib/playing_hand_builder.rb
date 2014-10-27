require 'straight_flush'
require 'four_of_a_kind'
require 'full_house'
require 'flush'
require 'straight'
require 'three_of_a_kind'
require 'two_pair'
require 'pair'
require 'high_card'
require 'card'

class PlayingHandBuilder
	def self.build(cards)
		return FoldedHand.new unless cards.size == 5
		return StraightFlush.new(cards) if straight_flush?(cards)
		return FourOfAKind.new(cards) if four_kind?(cards)
		return FullHouse.new(cards) if full_house?(cards)
		return Flush.new(cards) if flush?(cards)
		return Straight.new(cards) if straight?(cards)
		return ThreeOfAKind.new(cards) if three_of_a_kind?(cards)
		return TwoPair.new(cards) if two_pair?(cards)
		return Pair.new(cards) if single_pair?(cards)
		HighCard.new(cards)
	end

	private
		def self.straight_flush?(cards)
			flush?(cards) && straight?(cards)
		end

		def self.four_kind?(cards)
			group_by_value(cards).select {|card_value, count| count == 4}.length > 0
		end

		def self.full_house?(cards)
			grouped = group_by_value(cards)
			more_than_one_pair = grouped.select {|card_value, count| count >= 2}.length > 1
			three_of_a_kind?(cards) && more_than_one_pair		
		end

		def self.flush?(cards)
			cards.map {|c| c[1] }.uniq.one?
		end

		def self.straight?(cards)
			sorted_indexes = cards.map {|c| Card::VALUES.find_index c[0] }.uniq.sort
			return true if sorted_indexes.size == 5 && (sorted_indexes.last - sorted_indexes.first == 4)
			return true if low_straight?(cards)
			false
		end

		def self.low_straight?(cards)
			sorted_indexes = cards.map {|c| Card::VALUES.find_index c[0] }.uniq.sort
			count = sorted_indexes.count
			top = sorted_indexes.last
			count == 5 && sorted_indexes.first == 0 && top == 12 && sorted_indexes[3] == 3
		end

		def self.three_of_a_kind?(cards)
			group_by_value(cards).select {|card_value, count| count == 3}.length > 0
		end

		def self.two_pair?(cards)
			group_by_value(cards).select {|card_value, count| count == 2}.length > 1
		end

		def self.single_pair?(cards)
			card_values = cards.map {|c| c[0] }
			card_values.length - 1 == card_values.uniq.length
		end

		def self.group_by_value(cards)
			card_values = cards.map {|c| c[0] }
			card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
		end
end