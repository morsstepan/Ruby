require_relative 'straight_line'
require_relative 'point'
require_relative 'reading_module'
# A base module for base calculating methods
module CalculatingModule
  def self.process_equation(a, b, c)
    exit if are_a_b_zeros?(a, b) == true
    line = StraightLine.new(a, b, c)
    line
  end

  def self.are_a_b_zeros?(a, b)
    puts 'An equation does not exist' if a.zero? && b.zero?
    return true if a.zero? && b.zero?
  end

  def self.validation(a)
    !Float(a)
  rescue
    puts 'Wrong input data!'
    exit
  end

  def self.input_variable
    a = $stdin.gets.strip
    a = Float(a) if validation(a) == false
    a
  end

  def self.create_line
    puts 'Input the coefficients A, B and C'
    puts 'A: '
    a = input_variable
    puts 'B:'
    b = input_variable
    puts 'C:'
    c = input_variable
    line = process_equation(a, b, c)
    line
  end

  def self.create_point
    puts 'Input the point'
    puts 'X:'
    x = input_variable
    puts 'Y:'
    y = input_variable
    point = Point.new(x, y)
    point
  end

  def self.find_parallel_line_passing_through_point(line, point)
    c = line.a * point.abscissa + line.b * point.ordinate
    c *= -1
    parallel_line = StraightLine.new(line.a, line.b, c)
    puts 'A parallel line to the given one:'
    parallel_line.print_line
  end

  def self.find_perpendicular_line_passing_through_point(line, point)
    a = line.b * -1
    b = line.a
    c = a * point.abscissa + b * point.ordinate
    c *= -1
    perpendicular_line = StraightLine.new(a, b, c)
    puts 'A perpendicular line to the given one:'
    perpendicular_line.print_line
  end

  def self.determine_position_of_points(line, points)
    on_line?(line, points)
    above_line?(line, points)
    below_line?(line, points)
  end

  def self.above_line?(line, points)
    points.each do |point|
      sum = line.a * point.abscissa + line.b * point.ordinate + line.c
      if sum.positive?
        puts "A point (#{point.abscissa},#{point.ordinate}) is above the line"
      end
    end
  end

  def self.below_line?(line, points)
    points.each do |point|
      sum = line.a * point.abscissa + line.b * point.ordinate + line.c
      if sum.negative?
        puts "A point (#{point.abscissa},#{point.ordinate}) is below the line"
      end
    end
  end

  def self.on_line?(line, points)
    points.each do |point|
      sum = line.a * point.abscissa + line.b * point.ordinate + line.c
      if sum.zero?
        puts "A point (#{point.abscissa},#{point.ordinate}) is on the line"
      end
    end
  end

  def self.process_line(line, point, data_from_file)
    puts 'An entered line: '
    line.print_line
    find_parallel_line_passing_through_point(line, point)
    find_perpendicular_line_passing_through_point(line, point)
    determine_position_of_points(line, data_from_file)
    UserInteraction.show_menu?
  end

  def self.show_points(points)
    points.each(&:print_point)
    UserInteraction.show_menu?
  end
end
