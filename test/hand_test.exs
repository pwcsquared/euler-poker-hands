defmodule HandTest do
  use ExUnit.Case
  doctest PokerHands

  test "sorts hand by rank ascending" do
    assert Hand.sort_by_rank(["4H", "2S", "AH", "5C", "JH"]) == ["2S", "4H", "5C", "JH", "AH"]
  end

  test "sorts hand by suit ascending" do
    assert Hand.sort_by_suit(["4H", "2S", "AH", "5C", "JH"]) == ["5C", "2S", "4H", "AH", "JH"]
  end

  test "determines if all cards in hand are of same suit" do
    assert Hand.is_same_suit(["4H", "2S", "AH", "5C", "JH"]) == false
    assert Hand.is_same_suit(["4C", "2C", "AC", "5C", "JC"]) == true
  end

  test "splits hand into lists of ranks" do
    assert Hand.chunk_by_rank(["4H", "JS", "AH", "5C", "JH"]) ==
             [
               ["4H"],
               ["5C"],
               ["JS", "JH"],
               ["AH"]
             ]
  end

  test "splits hand into links of suits" do
    assert Hand.chunk_by_suit(["4H", "JS", "AH", "5C", "JH"]) ==
             [
               ["5C"],
               ["JS"],
               ["4H", "JH", "AH"]
             ]
  end

  test "counts length of sequences of ranks" do
    assert Hand.sequence_length(["TH"]) == 1
    assert Hand.sequence_length(["2S", "3C", "4H", "6D", "7D"]) == 2
    assert Hand.sequence_length(["TH", "JD", "QC", "KS", "AC"]) == 5
  end

  test "finds highest rank card in set of cards" do
    assert Hand.high_card(["KS", "4H", "8D", "TS", "9D"]) == "KS"
    assert Hand.high_card(["KS", "4H", "AD", "TS", "9D"]) == "AD"
  end
end
