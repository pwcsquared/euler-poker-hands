defmodule Poker.File do
  def run() do
    File.stream!("p054_poker.txt")
    |> Enum.map(&handle_line(&1))
    |> count_true()
  end

  def handle_line(line) do
    line
    |> String.trim()
    |> String.split_at(15)
    |> Tuple.to_list()
    |> Enum.map(&String.split(&1, "\s", trim: true))
    |> Poker.Game.compare_hands()
  end

  def count_true(list) do
    list
    |> Enum.reduce(0, fn x, acc ->
      if x == true do
        acc + 1
      else
        acc
      end
    end)
  end
end
