require_relative 'folded_hand' 

class Hand
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
		@best_hand ||= BestPlayingHandFinder.perform(@cards)
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
			best_hand
		end

		def self.folded?(cards)
			cards.length < 7
		end
	end

	def validate_hand_size
		@errors << "Unnacceptable hand size: #{@cards.length}" unless @cards.length.between?(2,8)
	end

	def validate_all_cards
		bad_cards = @cards.select {|c| !Card::VALUES.include?(c[0]) || !Card::SUITS.include?(c[1])}
		bad_cards.each { |c| @errors.push("#{c} is invalid card") }
	end

	def ensure_no_duplicates
		@errors << "Duplicate Cards!" if @cards.uniq! #uniq! return's nil if no dups
	end
end