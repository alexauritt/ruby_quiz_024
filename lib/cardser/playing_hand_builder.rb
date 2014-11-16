module Cardser
  class PlayingHandBuilder
    def self.build(cards)
      return Cardser::Hands::FoldedHand.new(cards) unless cards.size == 5
      Cardser::Hands::StraightFlush.build(cards) || 
      Cardser::Hands::FourOfAKind.build(cards) ||
      Cardser::Hands::FullHouse.build(cards) ||
      Cardser::Hands::Flush.build(cards) ||
      Cardser::Hands::Straight.build(cards) ||
      Cardser::Hands::ThreeOfAKind.build(cards) ||
      Cardser::Hands::TwoPair.build(cards) ||
      Cardser::Hands::Pair.build(cards)  ||
      Cardser::Hands::HighCard.build(cards)
    end
  end
end