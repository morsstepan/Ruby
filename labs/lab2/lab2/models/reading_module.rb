require_relative 'additional_models'
require_relative 'models'
require 'csv'
# A basic module for input operations
module ReadingModule
  def self.read_data
    if ARGV.empty?
      puts 'Please, specify data file.'
      exit
    else
      apartments = process_file
    end
    apartments
  end

  def self.finish?
    puts 'Do you want to continue working with this program? (y/n)'
    case $stdin.gets.strip
    when 'n' then exit
    when 'y' then return
    else
      puts 'Error!'
      exit
    end
  end

  def self.validation(a)
    !Integer(a)
  rescue
    puts "A file has unexpected symbol '#{a}'!"
    puts "WARNING: If you choose 'y', problem lines will be auto-corrected!"
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

  def self.check_file(file_name)
    puts "Processing file #{file_name}"
    file_exists?(file_name)
    file_empty?(file_name)
  end

  def self.process_file
    apartments = Apartments.new
    ARGV.each do |file_name|
      check_file(file_name)
      apartments = read_csv(apartments, file_name)
    end
    apartments
  end

  def self.create_apartment(row)
    Apartment.new(row['Footage'], row['Rooms'],
                  create_adress(row),
                  row['Floor'],
                  row['Apartment_type'], row['Floors'],
                  row['Price'],
                  create_conditions(row))
  end

  def self.create_adress(row)
    Adress.new(row['District'],
               row['Street'],
               row['Apartment'])
  end

  def self.create_conditions(row)
    ExchangeConditions.new(row['Wanted_district'],
                           row['Wanted_street'],
                           row['Wanted_floor'])
  end

  def self.read_csv(apartments, file_name)
    CSV.foreach(file_name, headers: true) do |row|
      apartments << create_apartment(row)
    end
    apartments
  end
end
