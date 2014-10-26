require_relative 'folded_hand' 

class Hand
	SUITS = ['c','d','h','s']
	VALUES = ['A','2','3','4','5','6','7','8','9','T','J','Q','K']
	HANDS = [:straight_flush, :four_kind, :full_house, :flush, :straight,
		:three_kind, :two_pair, :pair, :high_card]
	
	def initialize(hand_string)
		@cards = hand_string.split
	end

	def valid?
		@errors = []
		validate_hand_size
		validate_all_cards
		ensure_no_duplicates
		@errors.empty?
	end

	def best_hand
		HandEvaluator.evaluate(@cards)
		# @best_hand ||= BestPlayingHandFinder.perform(cards)
	end

	def errors
		@errors
	end

	private
	class BestPlayingHandFinder
		
		def self.perform(cards)
			best_hand = FoldedHand.new			
			unless folded? cards
				cards.combination(5).to_a.each do |combination|
					new_hand = PlayingHandBuilder.build(combination)
					best_hand = new_hand if new_hand > best_hand
				end
			end
		end

		def self.folded?(cards)
			cards.length < 7
		end

	end
	class HandEvaluator
		def self.evaluate(cards)
			if has_straight_flush?(cards)
				return :straight_flush
			elsif has_four_of_a_kind?(cards)
				return :four_kind
			elsif has_full_house?(cards)
				return :full_house
			elsif has_flush?(cards)
				return :flush
			elsif has_straight?(cards)
				return :straight
			elsif has_three_of_a_kind?(cards)
				return :three_kind
			elsif has_two_pair?(cards)
				return :two_pair
			elsif has_single_pair?(cards)
				return :pair
			end
			return :high_card
		end

		def self.has_straight_flush?(cards)
			has_straight?(cards) && has_flush?(cards)
		end

		def self.has_four_of_a_kind?(cards)
			group_by_value(cards).select {|card_value, count| count == 4}.length > 0
		end

		def self.has_full_house?(cards)
			grouped = group_by_value(cards)
			more_than_one_pair = grouped.select {|card_value, count| count >= 2}.length > 1
			has_three_of_a_kind?(cards) && more_than_one_pair		
		end

		def self.has_flush?(cards)
			suit_count = cards.map {|c| c[1] }.each_with_object(Hash.new(0)) { |suit, counts| counts[suit] += 1 }
			suit_count.any? { |card_value, count| count >= 5 }
		end

		def self.has_straight?(cards)
			sorted_indexes = cards.map {|c| VALUES.find_index c[0] }.uniq.sort
			return true if sorted_indexes.size > 4 && (sorted_indexes[4] - sorted_indexes[0] == 4)
			return true if sorted_indexes.size > 5 && (sorted_indexes[5] - sorted_indexes[1] == 4)
			return true if sorted_indexes.size > 6 && (sorted_indexes[6] - sorted_indexes[2] == 4)
			return true if broadway_straight?(cards)
			false
		end

		def self.broadway_straight?(cards)
			sorted_indexes = cards.map {|c| VALUES.find_index c[0] }.uniq.sort
			count = sorted_indexes.count
			top = sorted_indexes.last
			count >= 5 && sorted_indexes.first == 0 && top == 12 && sorted_indexes[count - 4] == 9
		end

		def self.has_three_of_a_kind?(cards)
			group_by_value(cards).select {|card_value, count| count == 3}.length > 0
		end

		def self.has_two_pair?(cards)
			group_by_value(cards).select {|card_value, count| count == 2}.length > 1
		end

		def self.has_single_pair?(cards)
			card_values = cards.map {|c| c[0] }
			card_values.length - 1 == card_values.uniq.length
		end

		def self.group_by_value(cards)
			card_values = cards.map {|c| c[0] }
			card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
		end
	end

	def validate_hand_size
		@errors << "Unnacceptable hand size: #{@cards.length}" unless @cards.length.between?(2,8)
	end

	def validate_all_cards
		bad_cards = @cards.select {|c| !VALUES.include?(c[0]) || !SUITS.include?(c[1])}
		bad_cards.each { |c| @errors.push("#{c} is invalid card") }
	end

	def ensure_no_duplicates
		@errors << "Duplicate Cards!" if @cards.uniq! #uniq! return's nil if no dups
	end
end