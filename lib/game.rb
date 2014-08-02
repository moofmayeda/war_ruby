class Game
  attr_accessor(:player_1_name, :player_2_name, :player_1, :player_2)

  def initialize(player_1, player_2)
    @player_1_name = player_1
    @player_2_name = player_2
    @ranks = [["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9], ["10", 10], ["J", 11], ["Q", 12], ["K", 13], ["A", 14]]
    @suits = ["D", "C", "H", "S"]
    @ranks.each do |rank|
      @suits.each do |suit|
        Card.new({:rank => rank[0], :rank_value => rank[1], :suit => suit})
      end
    end
  end

  def deal
    @player_1 = Hand.new(Card.all[0..25])
    @player_2 = Hand.new(Card.all[26..51])
  end

  def battle
    @cards_in_battle = []
    soldier_1 = @player_1.cards.first
    soldier_2 = @player_2.cards.first
    while soldier_1.rank_value == soldier_2.rank_value
      @cards_in_battle << @player_1.cards[0..3]
      @cards_in_battle << @player_2.cards[0..3]
      @player_1.remove_card(@player_1.cards[0..3])
      @player_2.remove_card(@player_2.cards[0..3])
      soldier_1 = @player_1.cards.first
      soldier_2 = @player_2.cards.first
    end
    if soldier_1.rank_value > soldier_2.rank_value
      @player_1.cards.rotate!(1)
      @player_1.add_card([soldier_2, @cards_in_battle].flatten)
      @player_2.remove_card([soldier_2])
      player_1_name
    else
      @player_2.cards.rotate!(1)
      @player_2.add_card([soldier_1, @cards_in_battle].flatten)
      @player_1.remove_card([soldier_1])
      player_2_name
    end
  end

  def not_over
    if @player_1.number > 0 && @player_2.number > 0
      true
    else
      @player_1.number > @player_2.number ? @player_1_name : @player_2_name
    end
  end
end
