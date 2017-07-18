# A base class for a point
class Point
  attr_reader :abscissa, :ordinate
  def initialize(abscissa, ordinate)
    @abscissa = abscissa
    @ordinate = ordinate
  end

  def print_point
    puts "(#{abscissa.round(2)}, #{ordinate.round(2)})"
  end
end
