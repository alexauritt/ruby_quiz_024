class HighCard < PlayingHand
  def hand_ranking; 0 end
  def sort_cards_by_prominence!
    @cards.sort! {|a,b| b.value <=> a.value }
  end

  def valid?
    true
  end
end
