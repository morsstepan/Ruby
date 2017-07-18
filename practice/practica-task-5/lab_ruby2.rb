require 'csv'
def payed_for_now(payments)
  sum = 0
  payments.each { |payment| sum += payment[:amount] }
  sum.round(2)
end

def create_month_array(payments)
  months = payments.uniq { |payment| payment[:payed_for] }
  months
end

def payed_for_each_month(payments)
  month_array = payments.group_by { |row| row[:payed_for] }
  payed_for_each_month =
    month_array.each_with_object({}) do |(month, rows), totals|
      totals[month] = rows.reduce(0.0) do |sum, row|
        sum.round(2) + row[:amount].to_f.round(2)
      end
    end
  payed_for_each_month
end

def maximum_payment_for_the_last_month(payments)
  last_month = payments.max_by { |x| x[:payed_for] }
  max = 0
  payments.each do |payment|
    if payment[:payed_for] == last_month[:payed_for]
      max = payment[:amount] if max < payment[:amount]
    end
  end
  result = "The max payment in #{last_month[:payed_for]} is #{max.round(2)}"
  result
end

def payed_for_specified_month(payments, month)
  sum = 0
  payments.each do |payment|
    sum += payment[:amount] if payment[:payed_for] == month
  end
  result = "The total amount of payments in #{month} is " + sum.round(2).to_s
  result
end

def print_line
  puts '-' * 80
end

def process_file
  result = []
  ARGV.each do |file_name|
    # puts "Processing file #{file_name}"
    # if File.exist?(file_name)
    #   puts "WARNING! #{file_name} is empty" if File.zero?(file_name)
    #   result += read_file(file_name)
    # else puts "Error! #{file_name} not found!"
    # end
    check_file(file_name)
    result += read_file(file_name)
  end
  result
end

def combine_files_to_array
  payments = []
  if ARGV.empty?
    puts 'Specify a file as an argument'
    exit
  else
    payments = process_file
  end
  ARGV.clear
  # payments = process_file unless ARGV.empty?
  # ARGV.clear
  payments
end

def read_file(file_name)
  result = []
  CSV.foreach(file_name, headers: true) do |row|
    result.push(payed_on: row['Payment date'],
                payed_for: row['Payable month'],
                house_type: row['House'],
                apartment: row['Apartment'],
                amount: row['Amount of payment'].to_f)
  end
  result
end

def file_empty?(file_name)
  puts "A file #{file_name} is empty\n" if File.zero?(file_name)
  finish? if File.zero?(file_name)
end

def file_exists?(file_name)
  puts "Error! A file #{file_name} not found!" unless File.exist?(file_name)
  exit unless File.exist?(file_name)
end

def finish?
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

def check_file(file_name)
  puts "Processing file #{file_name}"
  file_exists?(file_name)
  file_empty?(file_name)
  unexpected_symbols?(file_name)
end

def unexpected_symbols?(file_name)
  CSV.foreach(file_name, headers: true) do |row|
    finish? if validation(row['Amount of payment']) == true
  end
end

def validation(a)
  !Float(a)
rescue
  puts "A file has unexpected symbol '#{a}'!"
  puts "WARNING: If you choose 'n', problem lines will be auto-corrected!"
  puts "For example, a field '#{a}' will be auto-corrected to '#{a.to_f}'"
  return true
end

def cls_console
  system 'cls'
  # system 'clear'
end

def print_options
  cls_console
  puts "This program is created for working with payments \n"
  puts "You have to enter a number for choosing the option \n"
  puts "[0] The total amount of payments for now\n"
  puts "[1] The total amount of payments for each payed month\n"
  puts "[2] The maximum payment for the last payed month\n"
  puts "[3] The total amount of payments for the specified payed month\n"
  puts "[4] Exit\n"
  print_line
end

def option_zero(payments)
  cls_console
  print_line
  puts 'You have selected the option #0'
  print_line
  puts "The total amount of payments for now: #{payed_for_now(payments)}"
  menu(payments)
end

def option_one(payments)
  cls_console
  print_line
  puts 'You have selected the option #1'
  print_line
  puts "Here is the total of payments for each payed month: \n"
  months = payed_for_each_month(payments)
  months.each { |a| p a }
  menu(payments)
end

def option_two(payments)
  cls_console
  print_line
  puts 'You have selected the option #2'
  print_line
  puts maximum_payment_for_the_last_month(payments)
  menu(payments)
end

def option_three(payments)
  cls_console
  print_line
  puts 'You have selected the option #3'
  choose_month(payments)
  print_line
  menu(payments)
end

def unexpected_option(payments)
  puts 'Error! Check your input data, please.'
  menu(payments)
end

def choose_month(payments)
  puts "Please, specify the month (for example, 2014-08)\n"
  print_line
  puts 'Available months are: '
  months = create_month_array(payments)
  months.each { |a| puts a[:payed_for] }
  print_line
  month = gets.chomp
  print_line
  process_month(month, months, payments)
end

def check_month(month, months)
  error = false
  months.each do |x|
    error = (month == x[:payed_for]) if error == false
  end
  error
end

def process_month(month, months, payments)
  error = check_month(month, months)
  if error == true
    cls_console
    sum = payed_for_specified_month(payments, month)
    puts sum
  else
    puts 'You have written an incorrect month.'
    puts 'Please, pay attention on the available months.'
  end
end

def menu(payments)
  print_options
  choice = gets.chomp
  case choice
  when '0' then option_zero(payments)
  when '1' then option_one(payments)
  when '2' then option_two(payments)
  when '3' then option_three(payments)
  when '4' then exit
  else unexpected_option(payments)
  end
end

def main
  puts "This program has been created by Stepan Morozov\n"
  print_line
  payments = combine_files_to_array
  menu(payments)
end
main
