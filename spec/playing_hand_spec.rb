require 'cardser'
require 'spec_helper'

describe 'PlayingHand comparisons' do

  let(:royal_sf) { "Tc Kc Qc Jc Ac".split}
  let(:sf) { "2s 4s 3s 6s 5s".split}
  let(:four_kings) { "Ks Kc Ad Kd Kh".split}
  let(:aces_full) { "As 3d Ac Ad 3s".split}
  let(:kings_full) { "Ks Kc Ad Kd As".split}

  describe "to_s" do
    specify { expect(Cardser::Hands::StraightFlush.new(sf).to_s).to eq("6s 5s 4s 3s 2s (StraightFlush)") }
  end

  describe ">" do
    context "by hand rank" do
      specify { expect(Cardser::Hands::FullHouse.new(aces_full) > Cardser::Hands::FourOfAKind.new(four_kings)).to be_falsey }
      specify { expect(Cardser::Hands::FourOfAKind.new(four_kings) > Cardser::Hands::FullHouse.new(aces_full)).to be_truthy }
      specify { expect {Cardser::Hands::FourOfAKind.new(four_kings) > 3}.to raise_error(ArgumentError) }	
    end

    context "by leading card value" do
      specify {
        expect(Cardser::Hands::StraightFlush.new(royal_sf) > Cardser::Hands::StraightFlush.new(sf)).to be_truthy 
      }

      specify { 
        expect(Cardser::Hands::FullHouse.new(aces_full) > Cardser::Hands::FullHouse.new(kings_full)).to be_truthy 
      }

      let(:king_flush) { Cardser::Hands::Flush.new("4s 8s Ks 2s 3s".split)}
      let(:ten_flush) { Cardser::Hands::Flush.new("5c Tc 2c 9c 3c".split)}
      let(:ten_flush_hearts) { Cardser::Hands::Flush.new("5h Th 2h 9h 3h".split)}
      specify { expect(king_flush > ten_flush).to be_truthy }
      specify { expect(king_flush > nil).to be_truthy }
      specify { expect(ten_flush > king_flush).to be_falsey }
      specify { expect(king_flush < ten_flush).to be_falsey }
      specify { expect(ten_flush < king_flush).to be_truthy }
      specify { expect(king_flush <= ten_flush).to be_falsey }
      specify { expect(ten_flush <= king_flush).to be_truthy }

      specify { expect(ten_flush > ten_flush_hearts).to be_falsey }
      specify { expect(ten_flush_hearts > ten_flush).to be_falsey }

      let(:queen_straight) {Cardser::Hands::Straight.new("Tc 9d Qc Jc 8c".split)}
      let(:nine_straight) {Cardser::Hands::Straight.new("5s 7c 6s 8s 9s".split)}
      specify { expect(queen_straight > nine_straight).to be_truthy }
      specify { expect(nine_straight > queen_straight).to be_falsey }

      let(:three_kind_7) { Cardser::Hands::ThreeOfAKind.new("7c 3s 7s 9c 7h".split) }
      let(:three_kind_6) { Cardser::Hands::ThreeOfAKind.new("6c 3s 6s 9c 6h".split) }
      let(:three_kind_7_ace_kicker) { Cardser::Hands::ThreeOfAKind.new("7c 3s 7s Ac 7h".split) }
      specify { expect(three_kind_7 > three_kind_6).to be_truthy }
      specify { expect(three_kind_6 > three_kind_7).to be_falsey }
      specify { expect(three_kind_7_ace_kicker > three_kind_7).to be_truthy }
      specify { expect(three_kind_7 > three_kind_7_ace_kicker).to be_falsey }

      let(:nines_over_3s) { Cardser::Hands::TwoPair.new("9d 3s 7s 9c 3h".split) }
      let(:nines_over_3s_king_kicker) { Cardser::Hands::TwoPair.new("9d 3s Ks 9c 3h".split) }
      let(:nines_over_4s) { Cardser::Hands::TwoPair.new("9d 4s 7s 9c 4h".split) }
      specify { expect(nines_over_4s > nines_over_3s).to be_truthy }
      specify { expect(nines_over_3s > nines_over_4s).to be_falsey }
      specify { expect(nines_over_3s_king_kicker > nines_over_3s).to be_truthy }
      specify { expect(nines_over_3s > nines_over_3s_king_kicker).to be_falsey }
    end

  end

  describe "other comparators" do
    specify { expect {Cardser::Hands::FourOfAKind.new + Cardser::Hands::FourOfAKind.new}.to raise_error(NoMethodError) }
    specify { expect {Cardser::Hands::FourOfAKind.new < Cardser::Hands::FourOfAKind.new}.to raise_error(NoMethodError) }	
  end

  it 'should sort cards' do
    expect(Cardser::Hands::StraightFlush.new(royal_sf).cards.map(&:display)).to eq(['Ac','Kc','Qc','Jc','Tc'])

    four_aces = "6s 7c 6d 6h 6c".split
    expect(Cardser::Hands::FourOfAKind.new(four_aces).cards.last.display).to eq('7c')

    cards = Cardser::Hands::FullHouse.new(kings_full).cards
    5.times do |i|
      if i < 3
        expect(cards[i]).to be_a_king
      else
        expect(cards[i]).to be_an_ace
      end
    end

    expect(Cardser::Hands::Straight.new("3s 6c 4d 5s 7c".split).cards.map(&:display)).to eq(['7c','6c','5s','4d','3s'])
    expect(Cardser::Hands::Flush.new("3s 6s Ts 7s 4s".split).cards.last.display).to eq('3s')

    three_kind_cards = Cardser::Hands::ThreeOfAKind.new("7c 3s 7s 9c 7h".split).cards

    5.times do |i|
      if i == 4
        expect(three_kind_cards[i]).to have_card_value(3)
      elsif i < 3
        expect(three_kind_cards[i]).to have_card_value(7)
      else
        expect(three_kind_cards[i]).to have_card_value(9)
      end
    end

    two_pair_cards = Cardser::Hands::TwoPair.new("9d 3s 7s 9c 3h".split).cards

    5.times do |i|
      if i < 2
        expect(two_pair_cards[i]).to have_card_value(9)
      elsif i < 4
        expect(two_pair_cards[i]).to have_card_value(3)
      else
        expect(two_pair_cards[i]).to have_card_value(7)
      end
    end

    pair_cards = Cardser::Hands::Pair.new("9d 3s Js 9c Kh".split).cards

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

    high_card = Cardser::Hands::HighCard.new("9d Js Qs Ac 2h".split).cards

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
