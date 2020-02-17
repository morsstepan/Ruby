require_relative 'drawing_module'
# A base module for an user interaction
module UIModule
  def self.print_menu_options
    puts 'This program was created for drawing the diagrams from YAML-file'
    puts '[1] Create the diagrams for each student'
    puts '[2] Print all courses and students'
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
    DrawingModule.choose_diagram_type
    show_menu?
  end

  def self.create_students
    data = ReadingModule.read_data
    students = ReadingModule.process_raw_students(data['students'])
    students
  end

  def self.create_courses
    data = ReadingModule.read_data
    students = ReadingModule.process_raw_students(data['students'])
    courses = ReadingModule.process_raw_courses(data['courses'], students)
    courses
  end

  def self.option_two
    puts '2'
    show_courses
    show_students
    show_menu?
  end

  def self.show_courses
    courses = create_courses
    puts 'Courses are: '
    courses.each do |course|
      puts "- #{course.name}"
    end
  end

  def self.show_students
    students = create_students
    puts 'Students are'
    students.each do |student|
      puts "- #{student.name}"
    end
  end

  def self.choose_menu_options(choice)
    case choice
    when 1
      option_one
    when 2
      option_two
    when 3
      exit
    else
      puts 'Error!'
    end
  end

  def self.main_menu
    print_menu_options
    choose_menu_options input_option
  end
end
