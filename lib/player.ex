defmodule ExMon.Player do
  @require_keys [:life, :name, :move_rnd, :move_avg, :move_heal]
  @max_life 100

  @enforce_keys @require_keys
  defstruct @require_keys

  def build(name, move_rnd, move_avg, move_heal) do
    %ExMon.Player{
      life: @max_life,
      name: name,
      move_avg: move_avg,
      move_heal: move_heal,
      move_rnd: move_rnd
    }
  end
end
