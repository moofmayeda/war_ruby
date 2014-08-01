class Game
  attr_accessor(:player_1_name, :player_2_name, :player_1, :player_2, :cards_to_move)

  def initialize(player_1, player_2)
    @player_1_name = player_1
    @player_2_name = player_2
    @turn = 1
  end

  def deck
    #figure out how to pass in a hash of ranks, values, and suits
    @ranks = [["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9], ["10", 10], ["J", 11], ["Q", 12], ["K", 13], ["A", 14]]
    @suits = ["D", "C", "H", "S"]
    @deck = []
    @ranks.each do |rank|
      @suits.each do |suit|
        @deck << Card.new({:rank => rank[0], :rank_value => rank[1], :suit => suit})
      end
    end
    @deck
  end

  def deal
    @deck.shuffle!
    @player_1 = Hand.new(@deck[0..25])
    @player_2 = Hand.new(@deck[26..51])
  end

  def battle
    if player_1.play_card > @player_2.play_card
      return @player_1
    elsif player_1.play_card < @player_2.play_card
      return @player_2
    else
      return "WAR!"
    end
  end
end
