require 'hand.rb'

describe 'Hand:HandEvaluator' do
	describe 'has_straight?' do
		it 'should find straights' do
			expect(Hand::HandEvaluator.has_straight?("As 2c 3s 4d 5c 7d 8h".split)).to be_truthy
			expect(Hand::HandEvaluator.has_straight?("6s 2c 8s 4d 5c 7d 8h".split)).to be_truthy
			expect(Hand::HandEvaluator.has_straight?("8s 4d 5c 7d 6h".split)).to be_truthy	
			expect(Hand::HandEvaluator.has_straight?("8s 4d 5c 7d 2h".split)).to be_falsey
		end
	end
end