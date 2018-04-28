#!/usr/bin/env ruby
require_relative "player.rb"
require_relative "card.rb"

class Game
  attr_accessor :player, :dealer, :deck, :bet_amount

  WIN_SCORE = 21
  NUM_DECKS = 6

  # Initial game set up by initializing 2 players and 6 decks
  def initialize
    @player = Player.new
    @dealer = Player.new
    @deck = []
    NUM_DECKS.times do
      for num in 1..13 do
        for suit in 1..4 do
          deck << Card.new(num, suit)
        end
      end
    end
  end

  # The game starts here
  def start
    puts "***BLACKJACK***"
    self.bet_amount = nil
    while(self.bet_amount.nil?)
      puts "Enter betting amount:\n"
      begin
        ## bet_amount can only be an Integer value
        @bet_amount = Integer(gets.chomp)
      rescue StandardError
        puts "Invalid bet amount. Please try again!\n\n"
        self.bet_amount = nil
      end
    end

    ## Dealing initial 2 cards to tha player and 1 card to dealer
    self.player.cards << remove_and_get_card_from_deck
    self.player.cards << remove_and_get_card_from_deck
    self.dealer.cards << remove_and_get_card_from_deck

    play_and_check_score
  end

  private

  ## Pick one random card from deck and remove it from deck
  def remove_and_get_card_from_deck
    return self.deck.delete_at(rand(0..(self.deck.size-1)))
  end

  ## Check player score for win, lose or continue playing
  def play_and_check_score
    print_cards_and_score
    if self.player.get_score == WIN_SCORE
      puts "\nYou Win. you got a #{WIN_SCORE}. Yayyie!"
    elsif self.player.get_score > WIN_SCORE
      puts "\nYou BUSTED! Better luck next time!\n"
    else
      make_decision
    end
  end

  ## Utility method to print cards and scores of player and dealer
  def print_cards_and_score
    puts "\nYour cards:"
    self.player.cards.map{|c| puts c.display_name}
    puts "\nCards of dealer:"
    self.dealer.cards.map{|c| puts c.display_name}
    puts "\nYour Score: #{self.player.get_score}, Dealer Score: #{self.dealer.get_score}"
  end

  ## Method for player to make decision to Hit or Stand
  def make_decision
    choice = nil
    while(choice.nil?)
      puts "\nDecision Making time. Choose one of the following : \n"
      puts "1. Hit\n"
      puts "2. Stand\n"
      choice = gets.chomp.to_i
      if(choice == 1)
        puts "------------------------------------------"
        puts "Dealing another card to you.."
        self.player.cards << remove_and_get_card_from_deck
        play_and_check_score
      elsif(choice == 2)
        play_and_check_score_dealer
      else
        puts "Invalid choice. Please try again.."
        choice = nil
      end

    end
  end

  ## Deal card(s) to dealer or compare dealer and player scores based on his score
  def play_and_check_score_dealer
    self.dealer.cards << remove_and_get_card_from_deck
    print_cards_and_score
    if self.dealer.get_score == WIN_SCORE
      puts "\nYou Lose! Dealer got a #{WIN_SCORE}!. Better luck next time!"
    elsif self.dealer.get_score <= 16
      puts "------------------------------------------"
      puts "Dealing another card to Dealer..."
      sleep 2
      play_and_check_score_dealer
    elsif self.dealer.get_score >= 17 && self.dealer.get_score < WIN_SCORE
      compare_final_scores
    else
      puts "\nDealer BUSTED. You Win.. Yayyie!\n"
    end
  end

  ## Comparing dealer and player scores
  def compare_final_scores
    puts "Your final score : #{self.player.get_score}"
    puts "Dealer final score : #{self.dealer.get_score}"

    ## Assuming the player wins in case of same scores
    if self.player.get_score >= self.dealer.get_score
      puts "\nYou Win.. Yayyie!\n"
    else
      puts "\nYou Lose! Better luck next time!\n"
    end
  end
end

game = Game.new
game.start