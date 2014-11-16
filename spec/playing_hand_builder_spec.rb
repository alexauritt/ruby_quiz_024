require 'cardser'

describe 'Cardser::PlayingHandBuilder' do
  it 'should build a straight flush' do
    expect(Cardser::PlayingHandBuilder.build("As 2s 3s 4s 5s".split)).to be_instance_of Cardser::Hands::StraightFlush
    expect(Cardser::PlayingHandBuilder.build("Jc Tc Ac Kc Qc".split)).to be_instance_of Cardser::Hands::StraightFlush
  end

  it 'should build four of a kind' do
    four_kind = 
    expect(Cardser::PlayingHandBuilder.build("As Ac Ad Ah 5s".split)).to be_instance_of Cardser::Hands::FourOfAKind
    expect(Cardser::PlayingHandBuilder.build("Ac 3d 3h 3s 3c".split)).to be_instance_of Cardser::Hands::FourOfAKind
  end

  it 'can build high card' do
    expect(Cardser::PlayingHandBuilder.build("Ac 2d 3h 5s 6c".split)).to be_instance_of Cardser::Hands::HighCard
  end

  it 'can build pair' do
    expect(Cardser::PlayingHandBuilder.build("Ac Ad 3h 5s 6c".split)).to be_instance_of Cardser::Hands::Pair
  end

  it 'can build two pair' do
    expect(Cardser::PlayingHandBuilder.build("Ac Ad 3h 3s 6c".split)).to be_instance_of Cardser::Hands::TwoPair
  end

  it 'can build three of a kind' do
    expect(Cardser::PlayingHandBuilder.build("Ac Ad Ah 3s 6c".split)).to be_instance_of Cardser::Hands::ThreeOfAKind
  end

  it 'can build a low straight' do
    expect(Cardser::PlayingHandBuilder.build("Ac 2d 3h 4s 5c".split)).to be_instance_of Cardser::Hands::Straight
  end

  it 'can build a mid straight' do
    expect(Cardser::PlayingHandBuilder.build("4c 7d 6h 8s 5s".split)).to be_instance_of Cardser::Hands::Straight
  end

  it 'can build a high straight' do
    expect(Cardser::PlayingHandBuilder.build("Ac Kd Qh Ts Js".split)).to be_instance_of Cardser::Hands::Straight
  end

  it 'can build a Cardser::Hands::Flush' do
    expect(Cardser::PlayingHandBuilder.build("Ac 2c 3c 6c 7c".split)).to be_instance_of Cardser::Hands::Flush
  end

  it 'can build full house' do
    expect(Cardser::PlayingHandBuilder.build("Ac Ad Ah 3s 3c".split)).to be_instance_of Cardser::Hands::FullHouse
  end
end