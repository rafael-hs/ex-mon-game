defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Rafael", :kick, :punch, :heal)
      computer = Player.build("robotinik", :kick, :punch, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Rafael", :kick, :punch, :heal)
      computer = Player.build("robotinik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "robotinik"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Rafael"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Rafael", :kick, :punch, :heal)
      computer = Player.build("robotinik", :kick, :punch, :heal)

      Game.start(computer, player)

      initial_value = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "robotinik"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Rafael"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == initial_value

      new_state = %{
        computer: %ExMon.Player{
          life: 83,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "robotinik"
        },
        player: %ExMon.Player{
          life: 92,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Rafael"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)
      expected_response = %{new_state | turn: :computer, status: :continue}
      assert expected_response == Game.info()
    end
  end
end
