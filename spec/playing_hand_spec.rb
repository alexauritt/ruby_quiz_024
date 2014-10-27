require 'spec_helper'

require 'playing_hand'
require 'full_house'
require 'four_of_a_kind'
require 'straight_flush'
require 'flush'
require 'straight'
require 'three_of_a_kind'
require 'two_pair'
require 'pair'
require 'high_card'

describe 'PlayingHand comparisons' do

	let(:royal_sf) { "Tc Kc Qc Jc Ac".split}
	let(:sf) { "2s 4s 3s 6s 5s".split}
	let(:four_kings) { "Ks Kc Ad Kd Kh".split}
	let(:aces_full) { "As 3d Ac Ad 3s".split}
	let(:kings_full) { "Ks Kc Ad Kd As".split}
	
	describe ">" do
		context "by hand rank" do
			specify { expect(FullHouse.new(aces_full) > FourOfAKind.new(four_kings)).to be_falsey }
			specify { expect(FourOfAKind.new(four_kings) > FullHouse.new(aces_full)).to be_truthy }
			specify { expect {FourOfAKind.new(four_kings) > 3}.to raise_error(ArgumentError) }	
		end

		context "by leading card value" do
			specify {
				expect(StraightFlush.new(royal_sf) > StraightFlush.new(sf)).to be_truthy 
			}

			specify { 
				expect(FullHouse.new(aces_full) > FullHouse.new(kings_full)).to be_truthy 
			}

			pending 'compare flushes'
			pending 'compare straights'
			pending 'compare 3 of kind'
			pending 'compare 2 pair'
			pending 'compare pair'
			pending 'compare high card'
		end

	end

	describe "other comparators" do
		specify { expect {FourOfAKind.new + FourOfAKind.new}.to raise_error(NoMethodError) }
		specify { expect {FourOfAKind.new < FourOfAKind.new}.to raise_error(NoMethodError) }	
	end

	it 'should sort cards' do
		expect(StraightFlush.new(royal_sf).cards).to eq(['Ac','Kc','Qc','Jc','Tc'])
		
		four_aces = "6s 7c 6d 6h 6c".split
		expect(FourOfAKind.new(four_aces).cards.last).to eq('7c')
		
		cards = FullHouse.new(kings_full).cards
		5.times do |i|
			if i < 3
				expect(cards[i]).to be_a_king
			else
				expect(cards[i]).to be_an_ace
			end
		end

		expect(Straight.new("3s 6c 4d 5s 7c".split).cards).to eq(['7c','6c','5s','4d','3s'])
		expect(Flush.new("3s 6s Ts 7c 4s".split).cards.last).to eq('7c')
		
		three_kind_cards = ThreeOfAKind.new("7c 3s 7s 9c 7h".split).cards
		
		5.times do |i|
			if i == 4
				expect(three_kind_cards[i]).to have_card_value(3)
			elsif i < 3
				expect(three_kind_cards[i]).to have_card_value(7)
			else
				expect(three_kind_cards[i]).to have_card_value(9)
			end
		end

		two_pair_cards = TwoPair.new("9d 3s 7s 9c 3h".split).cards
		
		5.times do |i|
			if i < 2
				expect(two_pair_cards[i]).to have_card_value(9)
			elsif i < 4
				expect(two_pair_cards[i]).to have_card_value(3)
			else
				expect(two_pair_cards[i]).to have_card_value(7)
			end
		end


		pair_cards = Pair.new("9d 3s Js 9c Kh".split).cards
		
		5.times do |i|
			if i < 2
				expect(pair_cards[i]).to have_card_value(9)
			elsif i < 3
				expect(pair_cards[i]).to be_a_king
			elsif i < 4
				expect(pair_cards[i]).to be_a_jack
			elsif i < 5
				expect(pair_cards[i]).to have_card_value(3)
			end
		end

		high_card = HighCard.new("9d Js Qs Ac 2h".split).cards
		
		5.times do |i|
			if i == 0
				expect(high_card[i]).to be_an_ace
			elsif i == 1
				expect(high_card[i]).to be_a_queen
			elsif i < 3
				expect(high_card[i]).to be_a_jack
			elsif i < 4
				expect(high_card[i]).to have_card_value(9)
			elsif i < 5
				expect(high_card[i]).to have_card_value(2)
			end
		end
	end
end
