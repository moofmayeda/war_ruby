require 'rspec'
require 'card'
require 'hand'
require 'game'

describe "Card" do
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

  describe "play_card" do
    it "displays the rank of the first card" do
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '5', :rank_value => 5, :suit => 'D'})
      test_card_3 = Card.new({:rank => 'J', :rank_value => 11, :suit => 'H'})
      test_hand = Hand.new([test_card_1, test_card_2, test_card_3])
      expect(test_hand.play_card).to eq 4
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
end

describe "Game" do
  describe "initialize" do
    it "initializes a game with 2 names" do
      test_game = Game.new("moof", "joseph")
      expect(test_game).to be_a Game
    end
  end

  describe "player_1" do
    it "displays player 1's name" do
      test_game = Game.new("moof", "joseph")
      expect(test_game.player_1_name).to eq "moof"
    end
  end

  describe "deck" do
    it "creates a 52 card deck" do
      test_game = Game.new("moof", "joseph")
      expect(test_game.deck[51].rank).to eq "A"
      expect(test_game.deck[51].suit).to eq "S"
    end
  end

  describe "deal" do
    it "randomizes the deck and deals 26 cards to each player" do
      test_game = Game.new("moof", "joseph")
      test_game.deck
      test_game.deal
      expect(test_game.player_1.cards.length).to eq 26
    end
  end

  describe "battle" do
    it "compares each player's top card and determines which player wins when they are not equal" do
      test_game = Game.new("moof", "joseph")
      test_game.deck
      test_game.stub(:shuffle)
      test_game.deal
      expect(test_game.battle).to eq test_game.player_2
    end

    it "compares each player's top card and returns 'war' when they are equal in value" do
      test_game = Game.new("moof", "joseph")
      test_card_1 = Card.new({:rank => '4', :rank_value => 4, :suit => 'C'})
      test_card_2 = Card.new({:rank => '4', :rank_value => 4, :suit => 'D'})
      test_game.player_1 = Hand.new([test_card_1])
      test_game.player_2 = Hand.new([test_card_2])
      expect(test_game.battle).to eq "WAR!"
    end
  end
end
