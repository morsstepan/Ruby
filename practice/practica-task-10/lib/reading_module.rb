require_relative 'person'
require_relative 'group'
require 'csv'
# A basic module for input operations
module ReadingModule
  def self.read_data
    if ARGV.empty?
      puts 'Please, specify data file.'
      exit
    else
      group = process_file
    end
    group
  end

  def self.finish?
    puts 'Do you want to stop this program? (y/n)'
    case $stdin.gets.strip
    when 'y' then exit
    when 'n' then return
    else
      puts 'Error!'
      exit
    end
  end

  def self.validation(a)
    !Integer(a)
  rescue
    puts "A file has unexpected symbol '#{a}'!"
    puts "WARNING: If you choose 'n', problem lines will be auto-corrected!"
    puts "For example, a field '#{a}' will be auto-corrected to '#{a.to_f}'"
    return true
  end

  def self.file_exists?(file_name)
    puts "Error! A file #{file_name} not found!" unless File.exist?(file_name)
    exit unless File.exist?(file_name)
  end

  def self.file_empty?(file_name)
    puts "A file #{file_name} is empty\n" if File.zero?(file_name)
    finish? if File.zero?(file_name)
  end

  def self.unexpected_symbols?(file_name)
    CSV.foreach(file_name, headers: true) do |row|
      finish? if validation(row['Birth_day']) == true ||
                 validation(row['Birth_month']) == true ||
                 validation(row['Birth_year']) == true
    end
  end

  def self.check_file(file_name)
    puts "Processing file #{file_name}"
    unexpected_symbols?(file_name)
    file_exists?(file_name)
    file_empty?(file_name)
  end

  def self.process_file
    group = Group.new
    ARGV.each do |file_name|
      check_file(file_name)
      group = create_object(group, file_name)
    end
    group
  end

  def self.create_object(group, file_name)
    CSV.foreach(file_name, headers: true) do |row|
      group << Person.new(row['Surname'], row['Name'], row['Patronymic'],
                          row['Sex'], row['Birth_day'].to_i,
                          row['Birth_month'].to_i, row['Birth_year'].to_i,
                          row['City'])
    end
    group
  end
end
