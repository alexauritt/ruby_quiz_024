module Cardser
  class Card
    include Comparable
    SUITS = ['c','d','h','s']
    VALUES = ['2','3','4','5','6','7','8','9','T','J','Q','K','A']
    attr_reader :suit

    def initialize(str)
      @str = str
      @value = str[0]
      @suit = str[1]
      raise ArgumentError, "#{@value} is unnacceptable card value" unless VALUES.include? @value
      raise ArgumentError, "#{@suit} is unacceptable suit" unless SUITS.include? @suit
    end

    def value
      VALUES.index(@value)
    end

    def display
      @str
    end

    def <=>(other)
      raise ArgumentError, "a Card can only be compared to another Card" unless other.is_a? Card
      value <=> other.value
    end
  end
end