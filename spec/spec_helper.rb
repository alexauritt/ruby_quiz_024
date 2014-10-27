RSpec::Matchers.define :be_an_ace do 
  match do |actual|
    actual.display[0] == 'A'
  end
end

RSpec::Matchers.define :be_a_king do 
  match do |actual|
  	actual.display[0] == 'K'
  end
end

RSpec::Matchers.define :be_a_queen do 
  match do |actual|
    actual.display[0] == 'Q'
  end
end

RSpec::Matchers.define :be_a_jack do 
  match do |actual|
  	actual.display[0] == 'J'
  end
end


RSpec::Matchers.define :have_card_value do |card_value|
	if card_value == 10
		val = 'T'
	else
		val = card_value.to_s
	end
  match do |actual|
  	actual.display[0] == val
  end
end
