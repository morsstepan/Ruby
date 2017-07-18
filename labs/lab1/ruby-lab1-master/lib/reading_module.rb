require_relative 'point'
require 'csv'
# A base module for input operations
module ReadingModule
  # attr_accessor :my_csv_file
  # validates :my_csv_file, :csv => true
  def self.read_data
    if ARGV.empty?
      puts 'Please, specify data file.'
      exit
    else
      points = process_file
    end
    points
  end

  def self.finish?
    puts 'Do you want to stop this program? (y/n)'
    case $stdin.gets.strip
    when 'y'
      exit
    when 'n'
      return
    else
      puts 'Error!'
      exit
    end
  end

  def self.file_exists?(file_name)
    puts "Error! A file #{file_name} not found!" unless File.exist?(file_name)
    exit unless File.exist?(file_name)
  end

  def self.validation(a)
    !Float(a)
  rescue
    puts "A file has unexpected symbol '#{a}'!"
    puts "WARNING: If you choose 'n', problem lines will be auto-corrected!"
    puts "For example, a field '#{a}' will be auto-corrected to '#{a.to_f}'"
    return true
  end

  def self.file_empty?(file_name)
    puts "A file #{file_name} is empty\n" if File.zero?(file_name)
    finish? if File.zero?(file_name)
  end

  def self.unexpected_symbols?(file_name)
    CSV.foreach(file_name, headers: true) do |row|
      finish? if validation(row['X']) == true || validation(row['Y']) == true
    end
  end

  def self.check_file(file_name)
    puts "Processing file #{file_name}"
    file_exists?(file_name)
    file_empty?(file_name)
    unexpected_symbols?(file_name)
  end

  def self.process_file
    points = []
    ARGV.each do |file_name|
      check_file(file_name)
      CSV.foreach(file_name, headers: true) do |row|
        points.push(Point.new(row['X'].to_f,
                              row['Y'].to_f))
      end
    end
    points
  end
end
