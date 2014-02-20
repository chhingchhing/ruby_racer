require_relative 'racer_utils'

class RubyRacer
  attr_reader :players, :length, :die

  def initialize(players, length = 30)
    origin = Array.new(players.length, 0)
    @players = Hash[ players.zip(origin) ]
    @length = length
    @die = Die.new
  end

  def finished?
    players.has_value?(length)
  end

  def winner
    winners = []
    players.each { |player, position| winners << player if position == length }
    if winners.length == 1
      winners.pop
    else
      nil
    end
  end

  def advance_player!(player)
    players[player] += die.roll
    players[player] = length if players[player] > length
  end

  def print_board
    puts "=" * length + "==="
    players.each do |player, position|
      print "\#" + " " * position
      print "" + player[0]
      puts  " " * (length - position) + "*"
    end
    puts "=" * length + "==="
  end
end

players = ['Tony', 'John', 'Kelsey', 'Dan', 'Better Dan']

game = RubyRacer.new(players, 200)

clear_screen!

until game.finished?
  players.each do |player|
    move_to_home!

    game.print_board
    game.advance_player!(player)
    sleep(0.01)
  end
end

move_to_home!
game.print_board
the_winner = game.winner
puts "#{the_winner ||= 'Nobody'} won!"
