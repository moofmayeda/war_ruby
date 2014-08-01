require 'rspec'
require 'card'

describe "Card" do
  describe "initialize" do
    it "initializes a card with a rank and a suit" do
      test_card = Card.new('4','C')
      expect(test_card).to be_a Card
    end
  end

  describe "rank" do
    it "returns the rank of a card" do
      test_card = Card.new('4','C')
      expect(test_card.rank).to eq '4'
    end
  end

  describe "suit" do
    it "returns the suit of a card" do
      test_card = Card.new('4','C')
      expect(test_card.suit).to eq 'C'
    end
  end
end
