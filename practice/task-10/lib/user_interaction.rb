require_relative 'person'
require_relative 'group'
require_relative 'reading_module'
require_relative 'sorting_module'
require_relative 'saving_module'
# A basic module for an interaction with a user
module UserInteraction
  def self.print_menu_options
    puts 'Choose an option for working with this program (1/2)'
    puts '[1] Show people and save in the file'
    puts '[2] Exit'
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

  def self.show_groups
    puts 'Choose an option for working with this program (1/2/3/4)'
    puts 'All the files will be auto-saved into /results/ catalog'
    puts '[1] Show and save in the file namesakes'
    puts '[2] Show and save in the file people, who were born in the same month'
    puts '[3] Show and save in the file retirees'
    puts '[4] Back to main menu'
  end

  def self.group_option_one
    group = ReadingModule.read_data
    puts 'Namesakes: ' + "\n"
    sorted_group = SortingModule.people_by_surname(group)
    print_people sorted_group
    SavingModule.save_people_by_surname(group)
  end

  def self.print_people(sorted_by)
    sorted_by.each do |row|
      row[1].each { |person| puts person.return_person }
    end
  end

  def self.print_retirees(sorted_by)
    sorted_by.each { |person| puts person.return_person }
  end

  def self.group_option_two
    group = ReadingModule.read_data
    puts 'Born in the same month: ' + "\n"
    sorted_group = SortingModule.people_by_month(group)
    print_people sorted_group
    SavingModule.save_people_by_month(group)
  end

  def self.group_option_three
    group = ReadingModule.read_data
    puts 'Retirees: ' + "\n"
    sorted_group = SortingModule.people_by_year(group)
    print_retirees sorted_group
    SavingModule.save_people_by_year(group)
  end

  def self.group_option_four
    main_menu
  end

  def self.input_option
    $stdin.gets.to_i
  end

  def self.choose_menu_group_options(choice)
    case choice
    when 1 then group_option_one
    when 2 then group_option_two
    when 3 then group_option_three
    when 4 then group_option_four
    else
      puts 'Error!'
    end
  end

  def self.option_one
    puts 'Reading data from a file...'
    show_groups
    choose_menu_group_options input_option
  end

  def self.option_two
    exit
  end

  def self.choose_menu_options(choice)
    case choice
    when 1 then option_one
    when 2 then option_two
    else
      puts 'Error!'
    end
  end

  def self.main_menu
    print_menu_options
    choose_menu_options input_option
  end
end
