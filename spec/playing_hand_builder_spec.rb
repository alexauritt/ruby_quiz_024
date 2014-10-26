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
end