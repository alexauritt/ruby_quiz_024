class PlayingHandBuilder
	def self.build(cards)
		return FoldedHand.new unless cards.size == 5
    StraightFlush.build(cards) || 
    FourOfAKind.build(cards) ||
    FullHouse.build(cards) ||
    Flush.build(cards) ||
    Straight.build(cards) ||
    ThreeOfAKind.build(cards) ||
    TwoPair.build(cards) ||
    Pair.build(cards)  ||
		HighCard.build(cards)
	end
end