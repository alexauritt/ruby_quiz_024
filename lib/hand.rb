class Hand
	SUITS = ['c','d','h','s']
	VALUES = ['A','2','3','4','5','6','7','8','9','T','J','Q','K']
	
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

	def errors
		@errors
	end

	private
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