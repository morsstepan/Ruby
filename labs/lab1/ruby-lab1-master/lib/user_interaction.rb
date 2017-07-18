require_relative 'straight_line'
require_relative 'point'
require_relative 'reading_module'
require_relative 'calculating_module'
# A base module for an interaction with a user
module UserInteraction
  def self.print_menu_options
    puts 'This program was created to work with a straight line in the plane'
    puts '[1] Find a perpendicular and a parallel lines'
    puts '[2] Print all points from an entered file'
    puts '[3] Exit'
  end

  def self.show_menu?
    puts 'Would you like to open a menu window? (y/n)'
    choice = $stdin.gets.strip
    case choice
    when 'y'
      main_menu
    when 'n'
      exit
    else
      puts 'Error!'
    end
  end

  def self.input_option
    $stdin.gets.to_i
  end

  def self.option_one
    puts 'Reading points from a file...'
    data_from_file = ReadingModule.read_data
    puts 'Input the coefficients A, B, C and the coordinates of the point'
    line = CalculatingModule.create_line
    point = CalculatingModule.create_point
    CalculatingModule.process_line(line, point, data_from_file)
  end

  def self.option_two
    CalculatingModule.show_points(ReadingModule.read_data)
  end

  def self.option_three
    exit
  end

  def self.choose_menu_options(choice)
    case choice
    when 1
      option_one
    when 2
      option_two
    when 3
      option_three
    else
      puts 'Error!'
    end
  end

  def self.main_menu
    print_menu_options
    choose_menu_options input_option
  end
end
