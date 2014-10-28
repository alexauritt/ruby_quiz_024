class Hand
  include Comparable
  include CardConvertible
  
  def initialize(hand_string)
    @cards = hand_string.split
    convert_strings_to_cards_if_necessary!
  end

  def valid?
    @errors = []
    validate_hand_size
    validate_all_cards
    ensure_no_duplicates
    @errors.empty?
  end

  def <=>(other_hand)
    return 1 if other_hand.nil?
    raise ArgumentError, "a Hand can only be compared to another Hand" unless other_hand.is_a?(Hand)
    self.best_hand <=> other_hand.best_hand
  end
  
  def to_s
    @cards.map(&:display).join(" ").concat(" (#{self.best_hand.class.to_s})")
  end

  def best_hand
    @best_hand ||= find_best_hand
  end

  def errors
    @errors
  end

  private

  def find_best_hand
    unless folded?
      @cards.combination(5).to_a.each do |combination|
        new_hand = PlayingHandBuilder.build(combination)
        @best_hand = new_hand if new_hand > @best_hand
      end
    end
    @best_hand || FoldedHand.new(@cards)
  end

  def folded?
    @cards.length < 7
  end

  def validate_hand_size
    @errors << "Unnacceptable hand size: #{@cards.length}" unless @cards.length.between?(2,7)
  end

  def validate_all_cards
    bad_cards = @cards.select {|c| !Card::VALUES.include?(c.display[0]) || !Card::SUITS.include?(c.suit)}
    bad_cards.each { |c| @errors.push("#{c.display} is invalid card") }
  end

  def ensure_no_duplicates
    @errors << "Duplicate Cards!" if @cards.map(&:display).uniq! #uniq! return's nil if no dups
  end
end