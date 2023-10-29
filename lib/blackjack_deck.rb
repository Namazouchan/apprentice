require_relative 'blackjack_card'

class Deck
    SUITS = ['ハート', 'ダイヤ', 'クラブ', 'スペード']
    RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  
    def initialize
        @cards = SUITS.product(RANKS).map { |suit, rank| Card.new(rank, suit) }.shuffle
    end

    def draw
        @cards.pop
    end
end