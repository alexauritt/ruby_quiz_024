class PlayingHand
	attr_reader :cards

	def initialize(cards = [])
		@cards = cards
		convert_strings_to_cards_if_necessary!
		sort_cards_by_prominence!
	end

  def self.build(cards)
    instance = self.new(cards)
    instance.valid? ? instance : nil
  end
  
	def >(other_playing_hand)
		unless other_playing_hand.kind_of?(PlayingHand)
			raise ArgumentError, "Excpected instance of playing hand but received: #{other_playing_hand}" 
		end
		
		if superior_hand_rank?(other_playing_hand)
			true
		elsif inferior_hand_rank?(other_playing_hand)
			false
		else
			superior_card_values?(other_playing_hand)
		end
	end
	
	def four_kind?
		group_by_value.select {|card_value, count| count == 4}.length > 0
	end
	
	def full_house?
		grouped = group_by_value
		more_than_one_pair = grouped.select {|card_value, count| count >= 2}.length > 1
		three_of_a_kind? && more_than_one_pair		
	end
	
	def flush?
		@cards.map {|c| c.suit }.uniq.one?
	end
	
	def straight?
		sorted_indexes = @cards.map {|c| c.value }.uniq.sort
		return true if sorted_indexes.size == 5 && (sorted_indexes.last - sorted_indexes.first == 4)
		return true if low_straight?
		false
	end
	
	def low_straight?
		sorted_indexes = @cards.map {|c| c.value }.uniq.sort
		count = sorted_indexes.count
		top = sorted_indexes.last
		count == 5 && sorted_indexes.first == 0 && top == 12 && sorted_indexes[3] == 3
	end
	
	def three_of_a_kind?
		group_by_value.select {|card_value, count| count == 3}.length > 0
	end

	def two_pair?
		group_by_value.select {|card_value, count| count == 2}.length > 1
	end

	def single_pair?
		card_values = @cards.map {|c| c.value }
		card_values.length - 1 == card_values.uniq.length
	end
	
	def group_by_value
		card_values = @cards.map {|c| c.value }
		card_values.each_with_object(Hash.new(0)) { |card_val,counts| counts[card_val] += 1 }
	end
	
	
	private
  def convert_strings_to_cards_if_necessary!
    if @cards.first.is_a? String
      @cards = @cards.map { |card_string| Card.new(card_string) }
    end
  end
  
	def superior_hand_rank?(other_playing_hand)
		self.hand_ranking > other_playing_hand.hand_ranking
	end

	def inferior_hand_rank?(other_playing_hand)
		self.hand_ranking < other_playing_hand.hand_ranking
	end

	def superior_card_values?(other_playing_hand)
		5.times do |i|
			card_value = @cards[i].value
			other_card_value = other_playing_hand.cards[i].value
			return false if other_card_value > card_value
			return true if card_value > other_card_value
		end
		false
	end
	
  def valid?
    raise "should not validate in absract class"
  end
  
	def hand_ranking
		raise "attempt to call hand_ranking on abstract class"
	end

	def sort_cards_by_prominence!
		# raise "attempt to call sort_cards_by_prominence! on abstract class"
	end
end





