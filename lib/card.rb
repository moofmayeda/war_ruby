class Card
  attr_reader(:rank, :suit, :rank_value)

  @@cards = []

  def initialize(properties)
    @rank = properties[:rank]
    @rank_value = properties[:rank_value]
    @suit = properties[:suit]
    @@cards << self
  end

  def Card.all
    @@cards
  end

  def Card.clear
    @@cards = []
  end

  def Card.shuffle
    @@cards.shuffle!
  end
end
