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
    puts "\n\n"
    print_title("   T H E   G R E A T   S P E R M   R A C E   ")
    players.each do |player, position|
      print_lane(player, position)
    end
    print_bottom
  end

  private

  def print_title(title)
    puts title.center(length, '=')
  end

  def print_bottom
    puts "=" * length
  end

  def print_lane(name, pos)
    avatar = "~~#{name[0]}"
    start = "\#"
    to_go = "   [".rjust(length - pos)
    lane = ""
    # lane << start
    lane << avatar.rjust(pos)[-pos..-1]
    lane << to_go
    puts lane
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
           'Tony']#.shuffle

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
puts "* * *   congratulations!!! #{the_winner} will have babies!   * * *".upcase.center(207)
puts
puts
