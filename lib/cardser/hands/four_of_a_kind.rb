class FourOfAKind < PlayingHand
  def hand_ranking; 7 end

  def sort_cards_by_prominence!
    @cards.sort! {|a,b| b.value <=> a.value }
    unless @cards.first.value == @cards[1].value
      @cards.push @cards.shift
    end
  end

  def valid?
    four_kind?
  end
end
