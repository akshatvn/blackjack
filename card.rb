class Card
  attr_accessor :number, :suit, :points

  SUIT_MAP = {
    1 => "\e[#{31}m♥\e[0m",
    2 => "\e[#{30}m♠\e[0m",
    3 => "\e[#{31}m♦\e[0m",
    4 => "\e[#{30}m♣\e[0m"
  }

  FACE_CARDS_MAP = {
    1 => "Ace",
    11 => "Jack",
    12 => "Queen",
    13 => "King",
  }

  def initialize(number, suit)
    @number = number
    @suit = suit
    @points = get_points
  end

  # Instance method to get display value of a card (It's number and suit)
  def display_name
    if FACE_CARDS_MAP.keys.include?(self.number)
      "#{FACE_CARDS_MAP[self.number]} of #{SUIT_MAP[self.suit]}"
    else
      "#{self.number} \t #{SUIT_MAP[self.suit]}"
    end
  end

  private

  # Instance method to get points associated with each card
  def get_points
    if self.number == 1
      return 11
    elsif [11,12,13].include?(self.number)
      return 10
    else
      return self.number
    end
  end
end