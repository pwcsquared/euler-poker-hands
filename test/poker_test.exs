defmodule PokerGameTest do
  use ExUnit.Case
  doctest PokerHands

  import Poker.Game

  test "identifies straight flush in hand" do
    assert is_straight_flush(["6C", "5C", "4C", "3C", "7C"]) == true
    assert is_straight_flush(["AH", "JH", "QH", "KH", "TH"]) == true
    assert is_straight_flush(["3S", "4C", "5H", "6C", "7C"]) == false
  end

  test "identifies four of a kind in hand" do
    assert is_four_of_a_kind(["3C", "3D", "5C", "3H", "3S"]) == true
    assert is_four_of_a_kind(["3C", "3D", "5C", "3H", "TS"]) == false
  end

  test "identifies full house in hand" do
    assert is_full_house(["6C", "7D", "6D", "6S", "7H"]) == true
    assert is_full_house(["6C", "TD", "6D", "6S", "7H"]) == false
  end

  test "identifies flush in hand" do
    assert is_flush(["TH", "QH", "2H", "5H", "3H"]) == true
    assert is_flush(["6H", "2H", "8H", "KH", "4H"]) == true
    assert is_flush(["TH", "QH", "2S", "5H", "3D"]) == false
  end

  test "identifies straight in hand" do
    assert is_straight(["4H", "3H", "7S", "5H", "6D"]) == true
    assert is_straight(["TH", "QH", "2H", "5H", "3H"]) == false
  end

  test "identifies three of a kind in hand" do
    assert is_three_of_a_kind(["4H", "3H", "4S", "5H", "4D"]) == true
    assert is_three_of_a_kind(["QH", "TD", "2S", "TS", "3S"]) == false
  end

  test "identifies two pair in hand" do
    assert is_two_pair(["4H", "3H", "4S", "5H", "3D"]) == true
    assert is_two_pair(["QH", "TD", "2S", "TS", "3S"]) == false
  end

  test "identifies pair in hand" do
    assert is_pair(["4H", "3H", "4S", "5H", "JD"]) == true
    assert is_pair(["QH", "TD", "2S", "AS", "3S"]) == false
  end

  test "returns true if player 1 wins hand" do
    assert compare_hands([["KD", "8S", "9S", "7C", "2S"], ["3S", "6D", "6S", "4H", "KC"]]) ==
             false

    assert compare_hands([["TH", "TC", "QS", "8H", "5C"], ["JC", "JS", "KS", "9H", "4D"]]) ==
             false

    assert compare_hands([["5D", "5S", "AC", "KC", "3H"], ["4S", "4C", "QS", "7H", "2H"]]) ==
             true

    assert compare_hands([["5D", "5S", "AS", "KD", "3H"], ["5C", "5H", "AC", "KC", "2H"]]) ==
             true

    assert compare_hands([["6H", "4H", "5C", "3H", "2H"], ["3S", "QH", "5S", "6S", "AS"]]) ==
             true

    assert compare_hands([["TS", "8H", "9S", "6S", "7S"], ["QH", "3C", "AH", "7H", "8C"]]) ==
             true

    assert compare_hands([["TS", "8H", "9S", "6S", "7S"], ["6H", "2H", "8H", "KH", "4H"]]) ==
             false         

    assert compare_hands([["AD", "6C", "6S", "7D", "TH"], ["6H", "2H", "8H", "KH", "4H"]]) ==
             false
  end

  test "determines tie breakers" do
    assert handle_tie([["2C", "2H", "2S"], ["6C", "6S"]], [["3C", "3D", "3S"], ["5D", "5H"]]) ==
             false
  end

  test "ranks hands" do
    assert rank_hand(["2C", "5D", "2H", "5H", "KS"]) ==
             {:two_pair, [["5D", "5H"], ["2C", "2H"], ["KS"]]}

    assert rank_hand(["3C", "3D", "5D", "5H", "3S"]) ==
             {:full_house, [["3C", "3D", "3S"], ["5D", "5H"]]}

    assert rank_hand(["TS", "8H", "9S", "6S", "7S"]) ==
             {:straight, [["TS"], ["9S"], ["8H"], ["7S"], ["6S"]]}

    assert rank_hand(["AS", "QS", "KS", "JS", "TS"]) ==
             {:straight_flush, [["AS"], ["KS"], ["QS"], ["JS"], ["TS"]]}
  end
end
