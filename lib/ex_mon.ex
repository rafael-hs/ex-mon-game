defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.Status

  @robot_name "Robotinik"

  def create_player(name, move_avg, move_heal, move_rnd) do
    Player.build(name, move_avg, move_heal, move_rnd)
  end

  def start_game(player) do
    @robot_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message()
  end
end
