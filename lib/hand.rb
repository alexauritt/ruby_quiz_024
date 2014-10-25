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
	end

	def errors
		@errors
	end

	private
	class HandEvaluator
		def self.evaluate(cards)
			if has_three_of_a_kind?(cards)
				return :three_kind
			elsif has_two_pair?(cards)
				return :two_pair
			elsif has_single_pair?(cards)
				return :pair
			end
			return :high_card
		end

		def self.has_three_of_a_kind?(cards)
			card_values = cards.map {|c| c[0] }
			grouped = card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
			grouped.select {|card_value, count| count == 3}.length > 0
		end

		def self.has_two_pair?(cards)
			card_values = cards.map {|c| c[0] }
			grouped = card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
			grouped.select {|card_value, count| count == 2}.length > 1
		end

		def self.has_single_pair?(cards)
			card_values = cards.map {|c| c[0] }
			card_values.length - 1 == card_values.uniq.length
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