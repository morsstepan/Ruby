#Created by Stepan Morozov, IVT-22
def read_data(file_name)
  unless File.exists?(file_name)
    puts "File #{file_name} not found!"
    return nil
  end
  file = File.new(file_name)
  file.readlines
end
def validation(string)
  case
  when (string.nil? or string.empty?) then :no_input
  when string.include?(":") then :illegal_character
  else nil
  end
end
def convert_to_array(rows)
  rows.map do |string|
    string.strip.split(/\s+/).map do |num_string|
      if(is_number?(num_string))
        num_string.to_i
      else return nil
    end
    end
  end
end
def sort_by_char(ch_columns)
  ch_columns_index = Array.new(ch_columns.length){|a| a = a}
  for j in 0...ch_columns.length - 1 
    for i in 0...ch_columns.length - 1 
      if ch_columns[i] > ch_columns[i+1] then 
        temp_index=ch_columns_index[i] 
        temp = ch_columns[i] 
        ch_columns[i] = ch_columns[i+1] 
        ch_columns_index[i] = ch_columns_index[i+1] 
        ch_columns[i+1] = temp 
        ch_columns_index[i+1] = temp_index 
      end 
    end 
  end
  return ch_columns_index
end
def find_characteristic_columns(matrix)
  ch_columns = Array.new(matrix[0].length){|a| a = 0}
  ch_columns.each{|x| x=0}
  matrix.each_index {|i|
    matrix[i].each_index{|j|
      if(matrix[i][j] < 0 && matrix[i][j].odd?)
        ch_columns[j] += (-1)*matrix[i][j]
      end
      } 
  }
  ch_columns = sort_by_char(ch_columns)
end
def replace_characteristic_columns(matrix, ch_columns_index)
  result = Array.new(matrix.count) { Array.new(matrix[0].length)} #=> [[0, 1, 4], [0, 1, 4]]
  matrix.each_index {|i|
    matrix[i].each_index{|j|      
      result[i][j] = matrix[i][ch_columns_index[j]]
  }
  }
  return result
end
def is_number? string
  true if Integer(string) rescue false
end
def print_matrix(matrix)
  #matrix.to_a.each {|line| puts line.join("    ")}
  width = matrix.flatten.max.to_s.size+3
  puts matrix.map { |a| a.map { |i| i.to_s.rjust(width) }.join }
end
def check_dimensions(matrix)
  if matrix.any? { |e| e.is_a?(Array) }
    d = matrix.group_by { |e| e.is_a?(Array) && check_dimensions(e) }.keys
    [matrix.size] + d.first if d.size == 1 && d.first
  else
    [matrix.size]
  end
end
def process_file(file_name)
  puts "Processing #{file_name}"
  puts ("----------------------------------------------------------------------")
  rows = read_data(file_name)
  return unless rows
  numbers = convert_to_array(rows)
  if(numbers == nil)
    puts "Sorry, #{file_name} is not supported. Please, check your input data."
    puts ("----------------------------------------------------------------------")
  else
    validation_dim = check_dimensions(numbers)
    if(validation_dim == nil)
      puts "Sorry, a matrix dimension is incorrect. Please, check your input data."
      puts ("----------------------------------------------------------------------")
    else
      puts("An original matrix:")
      print_matrix numbers
      puts ("----------------------------------------------------------------------")
      puts("A modified matrix:")
      print_matrix replace_characteristic_columns(numbers, find_characteristic_columns(numbers))
      puts ("----------------------------------------------------------------------")
    end
  end
end
def delete_char(string)
  string.each_char{ |c| string.delete!(c) if c.ord<48 or c.ord>57 }
end
def main
  unless ARGV.empty?
    ARGV.each do |file_name|
      process_file(file_name)
    end
  end
end
main