require './lib/card'
require './lib/hand'
require './lib/game'

@suit_symbols = {'D' => "\u2666", 'C' => "\u2663", 'H' => "\u2665", 'S' => "\u2660"}

puts "\e[H\e[2J"
puts "*" * 88
puts "WAR " * 20
puts "*" * 88

print "Player One's name: "
name_1 = gets.chomp
print "Player Two's name: "
name_2 = gets.chomp

puts "\e[H\e[2J"
@game = Game.new(name_1, name_2)
Card.shuffle
@game.deal

def play
  puts "***CARD COUNT ***\t#{@game.player_1_name}: #{@game.player_1.number}\t\t#{@game.player_2_name}: #{@game.player_2.number}"
  puts "\t\t\t#{@game.player_1.cards.first.rank}#{@suit_symbols[@game.player_1.cards.first.suit]}\t\tVS\t#{@game.player_2.cards.first.rank}#{@suit_symbols[@game.player_2.cards.first.suit]}"
  @game.battle
  if @game.not_over == true
    puts "hit 'enter' for another round"
    gets.chomp
    puts "\e[H\e[2J"
    play
  end
end

play
puts "#{@game.not_over} WINS THE GAME!"
exit
