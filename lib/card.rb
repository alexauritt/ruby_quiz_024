class Card
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
end