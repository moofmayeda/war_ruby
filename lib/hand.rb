class Hand
  attr_accessor(:cards)

  def initialize(cards)
    @cards = cards
  end

  def remove_card(selected_cards)
    selected_cards.each {|card| @cards.delete(card)}
  end

  def add_card(selected_cards)
    @cards.concat(selected_cards)
  end

  def number
    @cards.length
  end
end
