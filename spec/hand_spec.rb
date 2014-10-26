require 'hand.rb'

describe "Hand" do

	describe 'find_best_hand' do
		let(:cards) { "As 2c 3s 4d 5c 7d 8h"}
		
		it 'should delegate to PlayingHandBuilder 21 times' do
			allow(PlayingHandBuilder).to receive(:build).and_return(FoldedHand.new)
			
			Hand.new(cards).best_hand
			
			expect(PlayingHandBuilder).to have_received(:build).exactly(21).times
		end
	end
	
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
			expect(Hand.new("Ac 2d 3h 5s 6c 7d Td").best_hand).to be_instance_of HighCard
		end

		it 'can identify pair' do
			expect(Hand.new("Ac Ad 3h 5s 6c 7d Td").best_hand).to be_instance_of Pair
		end

		it 'can identify two pair' do
			expect(Hand.new("Ac Ad 3h 3s 6c 7d Td").best_hand).to be_instance_of TwoPair
			expect(Hand.new("Ac Ad 3h 3s 6c 6d Td").best_hand).to be_instance_of TwoPair
		end

		it 'can identiy three of a kind' do
			expect(Hand.new("Ac Ad Ah 3s 6c 7d Td").best_hand).to be_instance_of ThreeOfAKind
		end

		it 'can find a low straight' do
			expect(Hand.new("Ac 2d 3h 4s 5c 7d Td").best_hand).to be_instance_of Straight
		end

		it 'can find a mid straight' do
			expect(Hand.new("Ac 7d 6h Js 5s 8d 9d").best_hand).to be_instance_of Straight
		end

		it 'can find a high straight' do
			expect(Hand.new("Ac 2d Qh Js 5s Kd Td").best_hand).to be_instance_of Straight
		end

		it 'can find a flush' do
			expect(Hand.new("Ac 2c 3c 4s 6c 7c Td").best_hand).to be_instance_of Flush
		end

		it 'can find full house' do
			expect(Hand.new("Ac Ad Ah 3s 3c 3d Td").best_hand).to be_instance_of FullHouse
		end

		it 'can find four of a kind' do
			expect(Hand.new("Ac Ad Ah As 3c 3d Td").best_hand).to be_instance_of FourOfAKind
		end

		it 'can find straight flush' do
			expect(Hand.new("Ac 2c 3c 4c 5c 3d Td").best_hand).to be_instance_of StraightFlush
		end

		it 'does not falsely identify straight flush if straight and flush are not same 5 cards' do
			expect(Hand.new("Ac 2c 3c 4c 5d Tc Td").best_hand).to be_instance_of Flush
		end
	end
end
