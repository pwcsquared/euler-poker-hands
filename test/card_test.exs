defmodule CardTest do
  use ExUnit.Case
  doctest PokerHands

  import Poker.Card

  test "gets card value as integer" do
    assert card_rank("2H") == 0
    assert card_rank("5C") == 3
    assert card_rank("TS") == 8
  end

  test "gets card suit as integer" do
    assert card_suit("2H") == 3
    assert card_suit("5C") == 0
    assert card_suit("TS") == 1
  end
end
