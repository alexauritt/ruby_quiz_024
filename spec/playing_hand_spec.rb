require 'playing_hand'
require 'full_house'
require 'four_of_a_kind'

describe 'PlayingHand comparisons' do
	describe ">" do
		specify { expect(FullHouse.new > FourOfAKind.new).to be_falsey }
		specify { expect(FourOfAKind.new > FullHouse.new).to be_truthy }
		specify { expect {FourOfAKind.new > 3}.to raise_error(ArgumentError) }	
	end

	describe "other comparators" do
		specify { expect {FourOfAKind.new + FourOfAKind.new}.to raise_error(NoMethodError) }
		specify { expect {FourOfAKind.new < FourOfAKind.new}.to raise_error(NoMethodError) }	
	end
end
