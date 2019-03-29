defmodule PokerTest do
  use ExUnit.Case
  doctest PokerHands

  test "identifies straight flush in hand" do
    assert Poker.is_straight_flush(["6C", "5C", "4C", "3C", "7C"]) == true
    assert Poker.is_straight_flush(["3S", "4C", "5H", "6C", "7C"]) == false
  end

  test "identifies four of a kind in hand" do
    assert Poker.is_four_of_a_kind(["3C", "3D", "5C", "3H", "3S"]) == true
    assert Poker.is_four_of_a_kind(["3C", "3D", "5C", "3H", "TS"]) == false
  end

  test "identifies full house in hand" do
    assert Poker.is_full_house(["6C", "7D", "6D", "6S", "7H"]) == true
    assert Poker.is_full_house(["6C", "TD", "6D", "6S", "7H"]) == false
  end

  test "identifies flush in hand" do
    assert Poker.is_flush(["TH", "QH", "2H", "5H", "3H"]) == true
    assert Poker.is_flush(["TH", "QH", "2S", "5H", "3D"]) == false
  end

  test "identifies straight in hand" do
    assert Poker.is_straight(["4H", "3H", "7S", "5H", "6D"]) == true
    assert Poker.is_straight(["TH", "QH", "2H", "5H", "3H"]) == false
  end

  test "identifies three of a kind in hand" do
    assert Poker.is_three_of_a_kind(["4H", "3H", "4S", "5H", "4D"]) == true
    assert Poker.is_three_of_a_kind(["QH", "TD", "2S", "TS", "3S"]) == false
  end

  test "identifies two pair in hand" do
    assert Poker.is_two_pair(["4H", "3H", "4S", "5H", "3D"]) == true
    assert Poker.is_two_pair(["QH", "TD", "2S", "TS", "3S"]) == false
  end

  test "identifies pair in hand" do
    assert Poker.is_pair(["4H", "3H", "4S", "5H", "JD"]) == true
    assert Poker.is_pair(["QH", "TD", "2S", "AS", "3S"]) == false
  end
end
