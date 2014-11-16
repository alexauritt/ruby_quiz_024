require 'cardser'

describe 'Card' do
  describe 'bad initialization' do
    specify { expect { Cardser::Card.new('ac') }.to raise_error(ArgumentError) }
    specify { expect { Cardser::Card.new('Ic') }.to raise_error(ArgumentError) }
    specify { expect { Cardser::Card.new('10d') }.to raise_error(ArgumentError) }
    specify { expect { Cardser::Card.new('3o') }.to raise_error(ArgumentError) }
  end

  describe 'good initialization' do
    specify { expect(Cardser::Card.new('Ac')).to be_an_instance_of(Cardser::Card) }
    specify { expect(Cardser::Card.new('Td')).to be_an_instance_of(Cardser::Card) }
    specify { expect(Cardser::Card.new('3h')).to be_an_instance_of(Cardser::Card) }
  end

  describe 'accessors' do
    let(:card) { Cardser::Card.new('Kc') }
    specify { expect(card.suit).to eq('c')}
    specify { expect(card.value).to eq(11)}
  end

  describe 'comparison' do
    let(:jack_c) { Cardser::Card.new("Jc") }
    let(:eight_d) { Cardser::Card.new("8d") }
    let(:jack_d) { Cardser::Card.new("Jd") }
    specify { expect(jack_c > eight_d).to be_truthy }
    specify { expect(jack_c >= eight_d).to be_truthy }
    specify { expect(jack_c < eight_d).to be_falsey }
    specify { expect(jack_c <= eight_d).to be_falsey }
    specify { expect(jack_c == jack_d).to be_truthy }
    specify { expect(jack_c >= jack_d).to be_truthy }
    specify { expect(jack_c <= jack_d).to be_truthy }
  end
end