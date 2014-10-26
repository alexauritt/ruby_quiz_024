require 'hand.rb'

class PlayingHandBuilder; end

describe 'Hand:BestPlayingHandFinder' do
	let(:cards) { "As 2c 3s 4d 5c 7d 8h".split }
	it 'should delegate to PlayingHandBuilder 21 times' do
		allow(PlayingHandBuilder).to receive(:build).and_return(FoldedHand.new)
	
		Hand::BestPlayingHandFinder.perform(cards)

		expect(PlayingHandBuilder).to have_received(:build).exactly(21).times
	end
end