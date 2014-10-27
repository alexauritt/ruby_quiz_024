require 'card.rb'

describe 'Card' do
  describe 'bad initialization' do
    specify { expect { Card.new('ac') }.to raise_error(ArgumentError) }
    specify { expect { Card.new('Ic') }.to raise_error(ArgumentError) }
    specify { expect { Card.new('10d') }.to raise_error(ArgumentError) }
    specify { expect { Card.new('3o') }.to raise_error(ArgumentError) }
  end
  
  describe 'good initialization' do
    specify { expect(Card.new('Ac')).to be_an_instance_of(Card) }
    specify { expect(Card.new('Td')).to be_an_instance_of(Card) }
    specify { expect(Card.new('3h')).to be_an_instance_of(Card) }
  end
  
  describe 'accessors' do
    let(:card) { Card.new('Kc') }
    specify { expect(card.suit).to eq('c')}
    specify { expect(card.value).to eq(11)}
  end
end