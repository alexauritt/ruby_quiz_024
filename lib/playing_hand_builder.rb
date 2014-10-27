require 'hands/straight_flush'
require 'hands/four_of_a_kind'
require 'hands/full_house'
require 'hands/flush'
require 'hands/straight'
require 'hands/three_of_a_kind'
require 'hands/two_pair'
require 'hands/pair'
require 'hands/high_card'
require 'card'

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