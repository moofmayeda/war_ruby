class Card
  attr_reader(:rank, :suit, :rank_value)

  def initialize(properties)
    @rank = properties[:rank]
    @rank_value = properties[:rank_value]
    @suit = properties[:suit]
  end
end
