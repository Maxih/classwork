class Card
  attr_accessor :value, :suit, :face_value

  def initialize(value, suit, face_value)
    @value = value
    @suit = suit
    @face_value = face_value
  end
end
