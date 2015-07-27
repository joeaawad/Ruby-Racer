require_relative 'racer_utils'

class RubyRacer
  attr_reader :players, :length

  def initialize(players, length = 30)
    @players_locations = {}
    players.each {|player| @players_locations[player] = 0}
    @length = length
    @rolldie = Die.new
  end

  def finished?
    @players_locations.each do |player, location|
      if location == @length
        return true
      end
    end
    false
  end

  def winner
    if finished?
      @players_locations.each { |player, location| return player if @players_locations[player] == @length}
    end
  end

  def advance_player!(player)
    @players_locations[player] += @rolldie.roll
    if @players_locations[player] > @length
      @players_locations[player] -= @length + 1
    end
  end

  def print_board
    @players_locations.each {|player, location| puts ("|" + (" |" * (location)) + player + "|" +  (" |" * (@length - location))) }
  end
end

players = ['a', 'b', 'c', 'd', 'e']

game = RubyRacer.new(players, 35)

clear_screen!

until game.finished?
  players.each do |player|
    move_to_home!

    game.print_board
    game.advance_player!(player)
    break if game.finished?

    sleep(0.3)
  end
end

move_to_home!
game.print_board

puts "Player '#{game.winner}' has won!"