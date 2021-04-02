defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings which represents a deck of cards
  """
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Foure",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = [
      "Spades",
      "Diamonds",
      "Hearts",
      "Clubs"
    ]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
    # My version
    # Enum.flat_map(
    #   suits,
    #   fn suit -> Enum.map(
    #     values,
    #     fn v -> v <> " of " <> suit end
    #   ) end
    # )
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and a remainder of the deck.
    The `amount` argument indicates the hand size.

  ## Examples

      iex> deck = Cards.create_deck
      iex> { hand, _rest } = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, amount) do
    Enum.split(deck, amount)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, content } -> :erlang.binary_to_term content
      { :error, _reason } -> "File does not exist or could not be read."
    end
  end

  def create_hand(amount) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(amount)
  end
end
