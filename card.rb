# Class manage cards and their values
class Card
  PICTURES = /^[VQK]$/.freeze
  attr_reader :value, :suit, :points

  def initialize(value, suit)
    @value = value
    @suit = suit
    @points = if value.to_i > 0
                value.to_i
              elsif value =~ PICTURES
                10
              else
                11
              end
  end

  def card_value(value)
    if value.to_i > 0
      card[0].to_i
    elsif value =~ PICTURES
      10
    else
      11
    end
  end

  private

  attr_writer :value, :suit, :points
end
