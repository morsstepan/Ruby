require 'chunky_png'
require_relative 'drawing_horizontal_diagram'
require_relative 'drawing_vertical_diagram'
# A base module for calculating operations
module DrawingModule
  def self.print_diagram_types
    puts 'What kind of diagrams would you like to create?'
    puts '[1] Horizontal bar chart'
    puts '[2] Vertical bar chart'
  end

  def self.choose_diagram_type
    print_diagram_types
    choice = $stdin.gets.strip
    case choice
    when '1'
      DrawingHorizontalDiagram.process_horizontal_diagram
    when '2'
      DrawingVerticalDiagram.process_vertical_diagram
    else
      puts 'Error!'
    end
  end
end
