class Straight < PlayingHand
  def hand_ranking; 4 end

  def sort_cards_by_prominence!
    @cards.sort! {|a,b| b.value <=> a.value }
  end

  def valid?
    straight?
  end
end
