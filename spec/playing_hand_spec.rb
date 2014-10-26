require 'playing_hand'
require 'full_house'
require 'four_of_a_kind'

describe 'FullHouse' do
	specify { expect(FullHouse.new < FourOfAKind.new).to be_truthy }
	specify { expect(FourOfAKind.new < FullHouse.new).to be_falsey }

	specify { expect(FullHouse.new > FourOfAKind.new).to be_falsey }
	specify { expect(FourOfAKind.new > FullHouse.new).to be_truthy }
		
	specify { expect(FullHouse.new == FullHouse.new).to be_truthy }
	specify { expect(FullHouse.new == FourOfAKind.new).to be_falsey }
		
	specify { expect(FourOfAKind.new != FullHouse.new).to be_truthy }
	specify { expect(FullHouse.new != FullHouse.new).to be_falsey }

	specify { expect(FullHouse.new <= FourOfAKind.new).to be_truthy }
	specify { expect(FourOfAKind.new <= FullHouse.new).to be_falsey }
	specify { expect(FourOfAKind.new <= FourOfAKind.new).to be_truthy }

	specify { expect(FullHouse.new >= FourOfAKind.new).to be_falsey }
	specify { expect(FourOfAKind.new >= FullHouse.new).to be_truthy }
	specify { expect(FourOfAKind.new >= FourOfAKind.new).to be_truthy }
	specify { expect {FourOfAKind.new + FourOfAKind.new}.to raise_error(NoMethodError) }	
end
