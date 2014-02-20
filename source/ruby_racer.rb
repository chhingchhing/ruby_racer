require_relative 'racer_utils'

class RubyRacer
  attr_reader :players, :length, :die

  def initialize(players, length = 30)
    origin = Array.new(players.length, 0)
    @players = Hash[ players.zip(origin) ]
    @length = length
    @die = Die.new
  end

  # Returns +true+ if one of the players has reached
  # the finish line, +false+ otherwise
  def finished?
    players.has_value?(length)
    # players.each {|_,position| return true if position >= 30}
    # false
  end

  # Returns the winner if there is one, +nil+ otherwise
  def winner
    # players.key(length)
    winners = []
    players.each { |player, position| winners << player if position == length }
    if winners.length == 1
      winners.pop
    else
      nil
    end
  end

  # Rolls the dice and advances +player+ accordingly
  def advance_player!(player)
    players[player] += die.roll
    players[player] = length if players[player] > length
    # restrict to max length
  end

  # Prints the current game board
  # The board should have the same dimensions each time
  # and you should use the "reputs" helper to print over
  # the previous board
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

# This clears the screen, so the fun can begin
clear_screen!

until game.finished?
  players.each do |player|
    # This moves the cursor back to the upper-left of the screen
    move_to_home!

    # We print the board first so we see the initial, starting board
    game.print_board
    game.advance_player!(player)
    # We need to sleep a little, otherwise the game will blow right past us.
    # See http://www.ruby-doc.org/core-1.9.3/Kernel.html#method-i-sleep
    sleep(0.01)
  end
end

# The game is over, so we need to print the "winning" board
move_to_home!
game.print_board
the_winner = game.winner
puts "#{the_winner ||= 'Nobody'} won!"
