require_relative 'blackjack_card'
require_relative 'blackjack_deck'

class Player
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit(deck)
    @cards << deck.draw
  end

    def score
        total = @cards.sum { |card| card.score }

        #合計が21を超える場合、10点引く
        @cards.each do |card|
            if card.rank == "A" && total > 21
                total -= 10
            end
        end
        total
    end
end