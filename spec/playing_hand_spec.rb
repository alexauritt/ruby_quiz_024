require 'playing_hand'
require 'full_house'
require 'four_of_a_kind'

describe 'FullHouse' do
	it "should know it's rank" do
		expect(FullHouse.new < FourOfAKind.new).to be_truthy
		expect(FourOfAKind.new < FullHouse.new).to be_falsey

		expect(FullHouse.new > FourOfAKind.new).to be_falsey
		expect(FourOfAKind.new > FullHouse.new).to be_truthy
		
		expect(FullHouse.new == FullHouse.new).to be_truthy
		expect(FullHouse.new == FourOfAKind.new).to be_falsey
		
		expect(FourOfAKind.new != FullHouse.new).to be_truthy
		expect(FullHouse.new != FullHouse.new).to be_falsey

		expect(FullHouse.new <= FourOfAKind.new).to be_truthy
		expect(FourOfAKind.new <= FullHouse.new).to be_falsey
		expect(FourOfAKind.new <= FourOfAKind.new).to be_truthy

		expect(FullHouse.new >= FourOfAKind.new).to be_falsey
		expect(FourOfAKind.new >= FullHouse.new).to be_truthy
		expect(FourOfAKind.new >= FourOfAKind.new).to be_truthy
	end
end
