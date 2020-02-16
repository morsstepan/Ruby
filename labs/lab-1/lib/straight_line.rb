# A basic class for a straight line
class StraightLine
  attr_reader :a, :b, :c
  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
  end

  def check_equation
    return false if a.zero? && b.zero?
  end

  def print_line
    equation = "#{a.round(2)}x + #{b.round(2)}y + #{c.round(2)} = 0"
    puts equation.gsub('+ -', '- ')
      .gsub('- -', '+ ')
      .gsub(/^\s*\+/, '')
      .gsub(/(?<=\d)\.0+(?=\D)/, '')
    # .gsub(/[+-]? ?0[a-z] ?/i, '')
  end

  def print_changed_line
    puts 'f'
  end
end
