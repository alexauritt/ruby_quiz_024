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

	describe "best_hand" do
		it 'can identify high card' do
			expect(Hand.new("Ac 2d 3h 5s 6c 7d Td").best_hand).to eq(:high_card)
		end

		it 'can identify pair' do
			expect(Hand.new("Ac Ad 3h 5s 6c 7d Td").best_hand).to eq(:pair)
		end

		it 'can identify two pair' do
			expect(Hand.new("Ac Ad 3h 3s 6c 7d Td").best_hand).to eq(:two_pair)
			expect(Hand.new("Ac Ad 3h 3s 6c 6d Td").best_hand).to eq(:two_pair)
		end

		it 'can identiy three of a kind' do
			expect(Hand.new("Ac Ad Ah 3s 6c 7d Td").best_hand).to eq(:three_kind)
		end

		it 'can find a straight' do
			expect(Hand.new("Ac 2d 3h 4s 5c 7d Td").best_hand).to eq(:straight)
		end

		it 'can find a flush' do
			expect(Hand.new("Ac 2c 3c 4s 6c 7c Td").best_hand).to eq(:flush)
		end

		it 'can find full house' do
			expect(Hand.new("Ac Ad Ah 3s 3c 3d Td").best_hand).to eq(:full_house)
		end

		it 'can find four of a kind' do
			expect(Hand.new("Ac Ad Ah As 3c 3d Td").best_hand).to eq(:four_kind)
		end

		it 'can find straight flush' do
			expect(Hand.new("Ac 2c 3c 4c 5c 3d Td").best_hand).to eq(:straight_flush)
		end
	end
end
