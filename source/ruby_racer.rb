require_relative 'racer_utils'

class RubyRacer
  attr_reader :players, :length, :die

  def initialize(players, length = 30)
    origin = Array.new(players.length, 0)
    @players = Hash[ players.zip(origin) ]
    @length = length
    @die = Die.new(4)
  end

  def finished?
    players.has_value?(length)
  end

  def winner
    winners = []
    players.each { |player, position| winners << player if position == length }
    winners
  end

  def advance_player!(player)
    players[player] += die.roll
    players[player] = length if players[player] > length
  end

  def print_board
    puts
    puts
    title = "   T H E   G R E A T   S P E R M   R A C E   "
    offset = title.length / 2
    puts "=" * (length/2 - offset) + "   T H E   G R E A T   S P E R M   R A C E   " + "=" * (length/2 - offset)
    players.each do |player, position|
      avatar = "~~#{player[0]}"
      if position == length
        racer = " "
        finish = " #{avatar} <-- CONCEPTION!!!"
      else
        racer = avatar
        finish = "* E G G"
      end
      print "\#" + " " * position
      print "" + racer
      puts  " " * (length - position) + finish
    end
    puts "=" * length + "====="
  end
end

players = ['Adam',
           'Andrew',
           'Ashlee',
           'Calder',
           'Cameron',
           'Dan',
           'Better Dan',
           'Devin',
           'Dinesh',
           'Greg',
           'Ian',
           'Jarrod',
           'John',
           'Kelsey',
           'Kenny',
           'Marco',
           'Michael',
           'Osagie',
           'Pablo',
           'Sarah',
           'Tony']

game = RubyRacer.new(players, 200)

clear_screen!

until game.finished?
  players.each do |player|
    game.advance_player!(player)
  end
  move_to_home!
  game.print_board
  sleep(0.1)
end

move_to_home!
game.print_board
the_winner = game.winner.join(" & ")
puts
puts "***   congratulations!!! #{the_winner} will have babies!   ***".upcase.center(207)
puts
puts
