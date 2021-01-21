defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Rafael"
      }

      assert expected_response == ExMon.create_player("Rafael", :kick, :punch, :heal)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Rafael", :kick, :punch, :heal)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Rafael", :kick, :punch, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
        ExMon.make_move(:kick)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:kick)
        end)

      assert messages =~ "The Player attack the computer"
      assert messages =~ "It's computer turn."
      assert messages =~ "It's player turn."
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:kick_wrong)
        end)

      assert messages =~ "Invalid Moviment: kick_wrong."
    end
  end
end
