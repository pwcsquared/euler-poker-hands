defmodule HandTest do
  use ExUnit.Case
  doctest PokerHands

  import Poker.Hand

  test "sorts hand by rank descending" do
    assert sort_by_rank(["4H", "2S", "AH", "5C", "JH"]) == ["AH", "JH", "5C", "4H", "2S"]
  end

  test "sorts hand by suit descending" do
    assert sort_by_suit(["4H", "2S", "AH", "5C", "JH"]) == ["4H", "AH", "JH", "2S", "5C"]
  end

  test "determines if all cards in hand are of same suit" do
    assert is_same_suit(["4H", "2S", "AH", "5C", "JH"]) == false
    assert is_same_suit(["4C", "2C", "AC", "5C", "JC"]) == true
  end

  test "splits hand into lists of ranks" do
    assert chunk_by_rank(["4H", "JS", "AH", "5C", "JH"]) ==
             [
               ["AH"],
               ["JS", "JH"],
               ["5C"],
               ["4H"]
             ]
  end

  test "splits hand into lists of suits" do
    assert chunk_by_suit(["4H", "JS", "AH", "5C", "JH"]) ==
             [
               ["AH", "JH", "4H"],
               ["JS"],
               ["5C"]
             ]
  end

  test "counts length of sequences of ranks" do
    assert sequence_length(["TH"]) == 1
    assert sequence_length(["2S", "3C", "4H", "6D", "7D"]) == 3
    assert sequence_length(["TH", "JD", "QC", "KS", "AC"]) == 5
  end

  test "finds highest rank card in set of cards" do
    assert high_card(["KS", "4H", "8D", "TS", "9D"]) == "KS"
    assert high_card(["KS", "4H", "AD", "TS", "9D"]) == "AD"
  end

  test "orders hands with sets according to set size" do
    assert sort_for_sets(["KD", "QD", "2S", "TD", "2D"]) == [
             ["2S", "2D"],
             ["KD"],
             ["QD"],
             ["TD"]
           ]
  end
end
