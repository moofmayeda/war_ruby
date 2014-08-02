require './lib/card'
require './lib/hand'
require './lib/game'

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
@game.deck
@game.deal

while @game.not_over
  puts "***CARD COUNT ***\t#{@game.player_1_name}: #{@game.player_1.number}\t\t#{@game.player_2_name}: #{@game.player_2.number}"
  puts "\t\t\t#{@game.player_1.cards.first.rank}\t\tVS\t#{@game.player_2.cards.first.rank}"
  @game.battle
  puts "hit 'enter' for another round"
  gets.chomp
  puts "\e[H\e[2J"
end

puts "#{@game.not_over} WINS THE GAME!"
exit
turn
