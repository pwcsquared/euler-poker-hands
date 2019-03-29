defmodule Poker do
  @poker_hands [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_a_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_a_kind,
    :straight_flush,
    :royal_flush
  ]

  def hand_rank(hand) do
    cond do
      is_straight_flush(hand) -> :straight_flush
      is_four_of_a_kind(hand) -> :four_of_a_kind
      is_full_house(hand) -> :full_house
      is_flush(hand) -> :flush
      is_straight(hand) -> :straight
      is_three_of_a_kind(hand) -> :three_of_a_kind
      is_two_pair(hand) -> :two_pair
      is_pair(hand) -> :one_pair
      true -> :high_card
    end
  end

  def compare_hands([hand1, hand2]) do
    hand1_rank = Enum.find_index(@poker_hands, &(&1 == hand_rank(hand1)))
    hand2_rank = Enum.find_index(@poker_hands, &(&1 == hand_rank(hand2)))

    hand1_rank > hand2_rank
  end

  def is_straight_flush(hand) do
    hand
    |> Hand.sort_by_rank()
    |> Hand.chunk_by_suit()
    |> List.first()
    |> Hand.sequence_length() == 5
  end

  def is_four_of_a_kind(hand) do
    hand
    |> Hand.sort_by_rank()
    |> Hand.chunk_by_rank()
    |> Enum.max_by(&length(&1))
    |> length == 4
  end

  def is_full_house(hand) do
    sorted_hand =
      hand
      |> Hand.sort_by_rank()
      |> Hand.chunk_by_rank()

    Enum.any?(sorted_hand, &(length(&1) == 3)) && length(sorted_hand) == 2
  end

  def is_flush(hand) do
    hand
    |> Hand.is_same_suit()
  end

  def is_straight(hand) do
    hand
    |> Hand.sort_by_rank()
    |> Hand.sequence_length() == 5
  end

  def is_three_of_a_kind(hand) do
    hand
    |> Hand.sort_by_rank()
    |> Hand.chunk_by_rank()
    |> Enum.any?(&(length(&1) == 3))
  end

  def is_two_pair(hand) do
    hand
    |> Hand.sort_by_rank()
    |> Hand.chunk_by_rank()
    |> Enum.filter(&(length(&1) == 2))
    |> length == 2
  end

  def is_pair(hand) do
    hand
    |> Hand.sort_by_rank()
    |> Hand.chunk_by_rank()
    |> Enum.any?(&(length(&1) == 2))
  end
end
