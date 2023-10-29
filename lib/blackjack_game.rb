require_relative 'blackjack_deck'
require_relative 'blackjack_player'

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Player.new
  end

  def start
    puts "ブラックジャックを開始します。"
    2.times do
      @player.hit(@deck)
      puts "あなたの引いたカードは#{@player.cards.last}です。"
      @dealer.hit(@deck)
    end
    puts "ディーラーの引いたカードは#{@dealer.cards.first}です。"
    puts "ディーラーの引いた2枚目のカードはわかりません。"

    player_turn
    dealer_turn if @player.score <= 21

    result
  end

  def player_turn
    while @player.score  < 21
      puts "あなたの得点は#{@player.score}です。カードを引きますか？(y/n)"
      user_input = gets.chomp
      if user_input == "y"
        @player.hit(@deck)
        puts "あなたの引いたカードは#{@player.cards.last}です。"
      elsif user_input == "n"
        break
      else
        puts "無効な選択です。yまたはnを入力してください。"
      end
    end
  end

  def dealer_turn
    puts "ディーラーの引いた2枚目のカードは#{@dealer.cards.last}でした。"
    while @dealer.score < 17
      @dealer.hit(@deck)
      puts "ディーラーの引いたカードは#{@dealer.cards.last}です。"
    end
    puts "ディーラーの現在の得点は#{@dealer.score}です。"
  end

  def result
    puts "あなたの得点は#{@player.score}です。"
    puts "ディーラーの得点は#{@dealer.score}です。"

    if @player.score > 21 || (@dealer.score <= 21 && @dealer.score >= @player.score)
      puts "あなたの負けです！"
    else
      puts "あなたの勝ちです！"
    end
    puts "ブラックジャックを終了します。"
  end
end