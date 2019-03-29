defmodule Hand do
  def sort_by_suit(hand) do
    hand
    |> Enum.sort(&(Card.card_suit(&1) <= Card.card_suit(&2)))
  end

  def sort_by_rank(hand) do
    hand
    |> Enum.sort(&(Card.card_rank(&1) <= Card.card_rank(&2)))
  end

  def chunk_by_rank(hand) do
    hand
    |> sort_by_rank
    |> Enum.chunk_by(&(13 - Card.card_rank(&1)))
  end

  def chunk_by_suit(hand) do
    hand
    |> sort_by_suit
    |> Enum.chunk_by(&(4 - Card.card_suit(&1)))
    |> Enum.map(&sort_by_rank(&1))
  end

  def sequence_length(hand) do
    hand
    |> sort_by_rank
    |> sequence_length(1)
  end

  def sequence_length([head | tail], length) do
    sequence_length(tail, Card.card_rank(head), length)
  end

  def sequence_length([head | tail], rank, length) do
    if Card.card_rank(head) == rank + 1 do
      sequence_length(tail, Card.card_rank(head), length + 1)
    else
      sequence_length(tail, Card.card_rank(head), 1)
    end
  end

  def sequence_length([], _, length), do: length

  def is_same_suit(hand) do
    hand
    |> Enum.map(&Card.card_suit(&1))
    |> Enum.uniq()
    |> length == 1
  end

  def high_card(hand) do
    hand
    |> Enum.max_by(&Card.card_rank(&1))
  end
end
