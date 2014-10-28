module CardConvertible
  def convert_strings_to_cards_if_necessary!
    @cards = @cards.map  do |c|
      c.is_a?(String) ? Card.new(c) : c
    end
  end
end