require 'playing_hand_builder'

describe 'PlayingHandBuilder' do
	it 'should build a straight flush' do
		straight_flush = "As 2s 3s 4s 5s".split
		expect(PlayingHandBuilder.build(straight_flush).class).to eq(StraightFlush)
	end

	it 'should build four of a kind' do
		four_kind = "As Ac Ad Ah 5s".split
		expect(PlayingHandBuilder.build(four_kind).class).to eq(FourOfAKind)
	end
end