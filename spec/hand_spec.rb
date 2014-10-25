require 'hand.rb'

describe "Hand" do
	describe "valid?" do
		it 'should be true if all cards are valid' do
			expect(Hand.new("Ac Th").valid?).to be_truthy
			expect(Hand.new("3c 6d 2s Th").valid?).to be_truthy
			expect(Hand.new("Ac 2c 6d Ad 6s 6h 9c").valid?).to be_truthy
		end

		it 'should be false if hand contains an invalid card' do
			expect(Hand.new("Ae Th").valid?).to be_falsey
			expect(Hand.new("1c 6d 2s Th").valid?).to be_falsey
		end

		it 'should be false if hand contains less than two cards' do
			expect(Hand.new("Ac").valid?).to be_falsey
		end

		it 'should be false if hand contains more than seven cards' do
			expect(Hand.new("Ac 1c 6d 2s Th 6s 6h 9c").valid?).to be_falsey
		end

		it 'should be false if hand contains any duplicates' do
			expect(Hand.new("Ac 2c 6d Ac 6s 6h 9c").valid?).to be_falsey
		end

	end
end
