defmodule Poker.Game do
  @poker_hands [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_a_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_a_kind,
    :straight_flush
  ]

  def rank_hand(hand) do
    sorted_hand = Poker.Hand.sort_for_sets(hand)

    cond do
      is_straight_flush(hand) ->
        {:straight_flush, sorted_hand}

      is_four_of_a_kind(hand) ->
        {:four_of_a_kind, sorted_hand}

      is_full_house(hand) ->
        {:full_house, sorted_hand}

      is_flush(hand) ->
        {:flush, sorted_hand}

      is_straight(hand) ->
        {:straight, sorted_hand}

      is_three_of_a_kind(hand) ->
        {:three_of_a_kind, sorted_hand}

      is_two_pair(hand) ->
        {:two_pair, sorted_hand}

      is_pair(hand) ->
        {:one_pair, sorted_hand}

      true ->
        {:high_card, sorted_hand}
    end
  end

  def compare_hands([hand1, hand2]) do
    {hand1_rank, sorted_hand1} = rank_hand(hand1)
    {hand2_rank, sorted_hand2} = rank_hand(hand2)

    rank_value1 = Enum.find_index(@poker_hands, &(&1 == hand1_rank))
    rank_value2 = Enum.find_index(@poker_hands, &(&1 == hand2_rank))

    if rank_value1 == rank_value2 do
      handle_tie(sorted_hand1, sorted_hand2)
    else
      rank_value1 > rank_value2
    end
  end

  def handle_tie([[card1 | _] | remaining1], [[card2 | _] | remaining2]) do
    if Poker.Card.card_rank(card1) == Poker.Card.card_rank(card2) do
      handle_tie(remaining1, remaining2)
    else
      Poker.Card.card_rank(card1) > Poker.Card.card_rank(card2)
    end
  end

  # if all card ranks are the same, count as player 1 loss
  def handle_tie([], []), do: false

  def is_straight_flush(hand) do
    hand
    |> Poker.Hand.sort_by_rank()
    |> Poker.Hand.chunk_by_suit()
    |> List.first()
    |> Poker.Hand.sequence_length() == 5
  end

  def is_four_of_a_kind(hand) do
    hand
    |> Poker.Hand.sort_by_rank()
    |> Poker.Hand.chunk_by_rank()
    |> Enum.max_by(&length(&1))
    |> length == 4
  end

  def is_full_house(hand) do
    sorted_hand =
      hand
      |> Poker.Hand.sort_by_rank()
      |> Poker.Hand.chunk_by_rank()

    Enum.any?(sorted_hand, &(length(&1) == 3)) && length(sorted_hand) == 2
  end

  def is_flush(hand) do
    hand
    |> Poker.Hand.is_same_suit()
  end

  def is_straight(hand) do
    hand
    |> Poker.Hand.sort_by_rank()
    |> Poker.Hand.sequence_length() == 5
  end

  def is_three_of_a_kind(hand) do
    hand
    |> Poker.Hand.sort_by_rank()
    |> Poker.Hand.chunk_by_rank()
    |> Enum.any?(&(length(&1) == 3))
  end

  def is_two_pair(hand) do
    hand
    |> Poker.Hand.sort_by_rank()
    |> Poker.Hand.chunk_by_rank()
    |> Enum.filter(&(length(&1) == 2))
    |> length == 2
  end

  def is_pair(hand) do
    hand
    |> Poker.Hand.sort_by_rank()
    |> Poker.Hand.chunk_by_rank()
    |> Enum.any?(&(length(&1) == 2))
  end
end
