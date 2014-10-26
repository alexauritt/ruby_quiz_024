require 'playing_hand_builder'

describe 'PlayingHandBuilder' do
	it 'should build a straight flush' do
		expect(PlayingHandBuilder.build("As 2s 3s 4s 5s".split)).to be_instance_of StraightFlush
		expect(PlayingHandBuilder.build("Jc Tc Ac Kc Qc".split)).to be_instance_of StraightFlush
	end

	it 'should build four of a kind' do
		four_kind = 
		expect(PlayingHandBuilder.build("As Ac Ad Ah 5s".split)).to be_instance_of FourOfAKind
		expect(PlayingHandBuilder.build("Ac 3d 3h 3s 3c".split)).to be_instance_of FourOfAKind
	end

	it 'can build high card' do
		expect(PlayingHandBuilder.build("Ac 2d 3h 5s 6c".split)).to be_instance_of HighCard
	end

	it 'can build pair' do
		expect(PlayingHandBuilder.build("Ac Ad 3h 5s 6c".split)).to be_instance_of Pair
	end

	it 'can build two pair' do
		expect(PlayingHandBuilder.build("Ac Ad 3h 3s 6c".split)).to be_instance_of TwoPair
	end

	it 'can build three of a kind' do
		expect(PlayingHandBuilder.build("Ac Ad Ah 3s 6c".split)).to be_instance_of ThreeOfAKind
	end

	it 'can build a low straight' do
		expect(PlayingHandBuilder.build("Ac 2d 3h 4s 5c".split)).to be_instance_of Straight
	end

	it 'can build a mid straight' do
		expect(PlayingHandBuilder.build("4c 7d 6h 8s 5s".split)).to be_instance_of Straight
	end

	it 'can build a high straight' do
		expect(PlayingHandBuilder.build("Ac Kd Qh Ts Js".split)).to be_instance_of Straight
	end

	it 'can build a flush' do
		expect(PlayingHandBuilder.build("Ac 2c 3c 6c 7c".split)).to be_instance_of Flush
	end

	it 'can build full house' do
		expect(PlayingHandBuilder.build("Ac Ad Ah 3s 3c".split)).to be_instance_of FullHouse
	end
end