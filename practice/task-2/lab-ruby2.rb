require 'csv'
def payed_for_now(payments)
    sum = 0
    payments.each { |a| sum+=a[:amount] }
    sum.round(2)
end
def create_month_array(payments)
    months = []
    months = payments.uniq { |a| a[:payed_for]}
    months
end
def payed_for_each_month(payments)
    month_array = payments.group_by { |row| row[:payed_for] }    
    payed_for_each_month = month_array.each_with_object({}) do |(month, rows), totals|
        totals[month] = rows.reduce(0.0) { |sum, row| sum + row[:amount].to_f }.round(2)
    end 
    payed_for_each_month
end
def maximum_payment_for_the_last_month(payments)
    last_month = payments.max_by {|x| x[:payed_for]}
    max = 0
    payments.each{|a|
        if(a[:payed_for] == last_month[:payed_for])
            if max < a[:amount]
                max = a[:amount]
            end
        end
    }
    result = "The last month is " + last_month[:payed_for].to_s + "\n" + "The maximum payment in #{last_month[:payed_for]} is " + max.round(2).to_s 
end 
def payed_for_specified_month(payments, month)
    sum=0
    payments.each{|x|
        if(x[:payed_for] == month)
            sum+=x[:amount]
        end
    }
    result = "The total amount of payments in #{month} is " +  sum.round(2).to_s
end
def print_line
    puts ("--------------------------------------------------------------------------------")
end
def combine_files_to_array(payments)
    payments = []
    unless (ARGV.empty?)
        ARGV.each do |file_name|
            puts "Processing file #{file_name}"
            if (File.exists?(file_name))
                if(File.zero?(file_name))
                    puts "WARNING! #{file_name} is empty"
                end
                payments += read_file(file_name)
            else
                puts "Error! #{file_name} not found!"
            end
        end
    end
    ARGV.clear
    payments
end
def read_file(file_name)
    result = []
    CSV.foreach(file_name, { headers: true }) do |row|
        result.push({
            payed_on: row["Payment date"],
            payed_for: row["Payable month"],
            house_type: row["House"],
            apartment: row["Apartment"],
            amount: row["Amount of payment"].to_f 
        })
    end
    result
end
def cls_console
    system "cls"
end
def help
    cls_console
    puts "- This program is created for working with payments \n"
    puts "- Press 0 to show the total amount of payments for now \n"
    puts "- Press 1 to show the total amount of payments for each payed month \n"
    puts "- Press 2 to show the maximum payment for the last payed month \n"
    puts "- Press 3 to show the total amount of payments for the specified payed month \n"
    puts "WARNING: You have to specify the month (for example, 2014-08)\n"
    puts "- Press 4 to show the help \n"
    puts "- Press 5 to exit from program \n"
end
def menu(payments)
    print_line
    puts "This program is created for working with payments \n"
    puts "You have to enter a number for choosing the option \n"
    puts "[0] The total amount of payments for now\n"
    puts "[1] The total amount of payments for each payed month\n"
    puts "[2] The maximum payment for the last payed month\n"
    puts "[3] The total amount of payments for the specified payed month\n"
    puts "[4] Exit\n"
    print_line
    choose=gets.chomp
    case choose
    when '0'
        cls_console
        print_line
        puts "You have selected the option #0"
        print_line
        puts "Here is the total amount of payments for now: " + payed_for_now(payments).to_s
        menu(payments)
        
    when '1'
        cls_console
        print_line
        puts "You have selected the option #1"
        print_line
        puts "Here is the total of payments for each payed month: \n"
        months = payed_for_each_month(payments)
        months.each{|a| p a}
        menu(payments)
    when '2'
        cls_console
        print_line
        puts "You have selected the option #2"
        print_line
        puts maximum_payment_for_the_last_month(payments)
        menu(payments)
    when '3'
        cls_console
        print_line
        puts "You have selected the option #3"
        print_line
        puts "Please, specify the month (for example, 2014-08)\n"
        print_line
        puts "Available months are: "
        months = create_month_array(payments)
        months.each{|a| puts a[:payed_for]}
        print_line
        month=gets.chomp
        print_line
        error = false
        months.each{|x| error = (month == x[:payed_for])}
        if(error == true)
            cls_console
            sum = payed_for_specified_month(payments, month)
            puts sum
        else
            puts "You have written an incorret month. Please, pay attention on the available months."
        end
        menu(payments)
    when '4'
        exit
    else
        puts 'Error! Check your input data, please.'
        menu(payments)
end
end
def main
    puts "This program has been created by Stepan Morozov\n"
    print_line
    payments = combine_files_to_array(payments)
    menu(payments)
end
main