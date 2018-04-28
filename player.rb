class Player
  attr_accessor :cards
  def initialize
    @cards = []
  end

  ## Instance method to get current score of a player
  def get_score
    score = 0
    self.cards.each do |card|
      score += card.points
    end
    score
  end
end