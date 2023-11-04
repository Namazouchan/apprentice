class Card
    attr_reader :rank, :suit
  
    def initialize(rank, suit)
      @rank = rank
      @suit = suit
    end

    def to_s
      "#{@suit}の#{@rank}"
    end
  
    def score
      case @rank
      when "A"
        11
      when "J", "Q", "K", "10"
        10
      else
        @rank.to_i
      end
    end
end

