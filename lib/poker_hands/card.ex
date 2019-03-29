defmodule Card do
  @card_ranks ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
  @card_suits ["C", "S", "D", "H"]

  def card_rank(card) do
    rank = String.first(card)
    Enum.find_index(@card_ranks, &(&1 == rank))
  end

  def card_suit(card) do
    suit = String.last(card)
    Enum.find_index(@card_suits, &(&1 == suit))
  end
end
