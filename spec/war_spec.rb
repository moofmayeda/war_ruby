require 'rspec'
require 'card'
require 'hand'
require 'game'

describe "Card" do

  before do
    Card.clear
  end

  describe "initialize" do
    it "initializes a card with a rank, rank value, and a suit" do
      test_card = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      expect(test_card).to be_a Card
    end
  end

  describe "rank" do
    it "returns the rank of a card" do
      test_card = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      expect(test_card.rank).to eq '4'
    end
  end

  describe "suit" do
    it "returns the suit of a card" do
      test_card = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      expect(test_card.suit).to eq 'C'
    end
  end

  describe ".all" do
    it "returns an array of all card instances" do
      test_card = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      expect(Card.all).to eq [test_card]
    end
  end

  describe ".clear" do
    it "clears out the array of all card instances" do
      test_card = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      Card.clear
      expect(Card.all).to eq []
    end
  end

  describe ".shuffle" do
    it "randomly shuffles the entire deck of cards" do
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'H'})
      Card.all.stub(:shuffle)
      expect(Card.all).to eq [test_card_1, test_card_2]
    end
  end
end

describe "Hand" do
  describe "initialize" do
    it "initializes a hand with an array of cards" do
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'D'})
      test_card_3 = Card.new({:rank => 'J', :rank_value => 11, :suit => 'H'})
      test_hand = Hand.new([test_card_1, test_card_2, test_card_3])
      expect(test_hand).to be_a Hand
    end
  end

  describe "cards" do
    it "displays the cards" do
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'D'})
      test_card_3 = Card.new({:rank => 'J', :rank_value => 11, :suit => 'H'})
      test_hand = Hand.new([test_card_1, test_card_2, test_card_3])
      expect(test_hand.cards).to eq [test_card_1, test_card_2, test_card_3]
    end
  end

  describe "remove_card" do
    it "removes an array of cards from a hand" do
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'D'})
      test_card_3 = Card.new({:rank => 'J', :rank_value => 11, :suit => 'H'})
      test_hand = Hand.new([test_card_1, test_card_2, test_card_3])
      test_hand.remove_card([test_card_1, test_card_3])
      expect(test_hand.cards).to eq [test_card_2]
    end
  end

  describe "add_card" do
    it "adds an array of cards to a hand" do
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'D'})
      test_card_3 = Card.new({:rank => 'J', :rank_value => 11, :suit => 'H'})
      test_hand = Hand.new([test_card_1, test_card_2])
      test_hand.add_card([test_card_3])
      expect(test_hand.cards).to eq [test_card_1, test_card_2, test_card_3]
    end
  end

  describe "number" do
    it "returns the number of cards in the hand" do
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'D'})
      test_card_3 = Card.new({:rank => 'J', :rank_value => 11, :suit => 'H'})
      test_hand = Hand.new([test_card_1, test_card_2, test_card_3])
      expect(test_hand.number).to eq 3
    end
  end
end

describe "Game" do

  before do
    Card.clear
  end

  describe "initialize" do
    it "initializes a game with 2 names" do
      test_game = Game.new("moof", "joseph")
      expect(test_game).to be_a Game
    end

    it "creates a 52 card deck" do
      test_game = Game.new("moof", "joseph")
      expect(Card.all[51].rank).to eq 'A'
      expect(Card.all[51].suit).to eq 'S'
    end
  end

  describe "player_1" do
    it "displays player 1's name" do
      test_game = Game.new("moof", "joseph")
      expect(test_game.player_1_name).to eq "moof"
    end
  end

  describe "deal" do
    it "deals 26 cards to each player" do
      test_game = Game.new("moof", "joseph")
      test_game.deal
      expect(test_game.player_1.cards.length).to eq 26
    end
  end

  describe "battle" do
    it "compares each player's top card and gives the winner both cards when they are not equal" do
      test_game = Game.new("moof", "joseph")
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'D'})
      test_game.player_1 = Hand.new([test_card_1])
      test_game.player_2 = Hand.new([test_card_2])
      test_game.battle
      expect(test_game.player_1.cards).to eq []
      expect(test_game.player_2.cards).to eq [test_card_2, test_card_1]
    end

    it "when top cards are equal, conduct a war and give the winner all the cards" do
      test_game = Game.new("moof", "joseph")
      test_card_1_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_1_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'C'})
      test_card_1_3 = Card.new({:rank => '6', :rank_value => 6, :suit => 'C'})
      test_card_1_4 = Card.new({:rank => '7', :rank_value => 7, :suit => 'C'})
      test_card_1_5 = Card.new({:rank => '6', :rank_value => 6, :suit => 'H'})
      test_card_2_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'D'})
      test_card_2_2 = Card.new({:rank => 'A', :rank_value => 14, :suit => 'D'})
      test_card_2_3 = Card.new({:rank => 'K', :rank_value => 13, :suit => 'D'})
      test_card_2_4 = Card.new({:rank => 'Q', :rank_value => 12, :suit => 'D'})
      test_card_2_5 = Card.new({:rank => 'J', :rank_value => 11, :suit => 'D'})
      test_game.player_1 = Hand.new([test_card_1_1, test_card_1_2, test_card_1_3, test_card_1_4, test_card_1_5])
      test_game.player_2 = Hand.new([test_card_2_1, test_card_2_2, test_card_2_3, test_card_2_4, test_card_2_5])
      expect(test_game.battle).to eq "joseph"
      expect(test_game.player_1.cards).to eq []
      expect(test_game.player_2.cards).to eq [test_card_2_5, test_card_1_5, test_card_1_1, test_card_1_2, test_card_1_3, test_card_1_4, test_card_2_1, test_card_2_2, test_card_2_3, test_card_2_4]
    end
  end

  describe "not_over" do
    it "returns true if the game should keep going" do
      test_game = Game.new("moof", "joseph")
      test_game.deal
      expect(test_game.not_over).to eq true
    end

    it "returns the winning player if the game is over" do
      test_game = Game.new("moof", "joseph")
      test_card_1_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_1_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'C'})
      test_game.player_1 = Hand.new([test_card_1_1, test_card_1_2])
      test_game.player_2 = Hand.new([])
      expect(test_game.not_over).to eq "moof"
    end
  end
end
