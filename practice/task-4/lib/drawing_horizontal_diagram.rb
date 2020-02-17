require_relative 'ui_module'
# A base module for drawing a horizontal diagram
module DrawingHorizontalDiagram
  def self.process_courses(courses, png, move, student)
    courses.each do |course|
      course.grades.each do |grades|
        move = create_horizontal_diagram(png, grades, move, student)
      end
    end
    file_name = student.name + ' (horizontal)'
    draw_line(png)
    png.save(file_name, interlace: true)
  end

  def self.draw_line(image)
    image.rect(0, 660, 1024, 670, ChunkyPNG::Color.rgb(0, 0, 0),
               ChunkyPNG::Color.rgb(0, 0, 0))
  end

  def self.five?(png, grades, move)
    draw_five_grade_block(png, move) if grades[:grade] == 5
  end

  def self.four?(png, grades, move)
    draw_four_grade_block(png, move) if grades[:grade] == 4
  end

  def self.three?(png, grades, move)
    draw_three_grade_block(png, move)   if grades[:grade] == 3
  end

  def self.two?(png, grades, move)
    draw_two_grade_block(png, move) if grades[:grade] == 2
  end

  def self.one?(png, grades, move)
    draw_one_grade_block(png, move) if grades[:grade] == 1
  end

  def self.create_horizontal_diagram(png, grades, move, student)
    if student.id == grades[:student_id].id
      five?(png, grades, move)
      four?(png, grades, move)
      three?(png, grades, move)
      two?(png, grades, move)
      one?(png, grades, move)
      move += 150
    end
    move
  end

  def self.process_horizontal_diagram
    puts 'Reading points from a file...'
    courses = UIModule.create_courses
    students = UIModule.create_students
    students.each do |student|
      draw_horizontal_diagram(student, courses)
    end
  end

  def self.draw_horizontal_diagram(student, courses)
    move = 0
    png = ChunkyPNG::Image.new(1024, 768, ChunkyPNG::Color.rgb(255, 255, 255))
    process_courses(courses, png, move, student)
  end

  def self.draw_five_grade_block(image, move)
    image.rect(150 + move, 660, 200 + move, 50, ChunkyPNG::Color.rgb(0, 0, 0),
               ChunkyPNG::Color.rgb(0, 255, 0))
  end

  def self.draw_four_grade_block(image, move)
    image.rect(150 + move, 660, 200 + move, 172, ChunkyPNG::Color.rgb(0, 0, 0),
               ChunkyPNG::Color.rgb(20, 120, 30))
  end

  def self.draw_three_grade_block(image, move)
    image.rect(150 + move, 660, 200 + move, 294, ChunkyPNG::Color.rgb(0, 0, 0),
               ChunkyPNG::Color.rgb(255, 140, 0))
  end

  def self.draw_two_grade_block(image, move)
    image.rect(150 + move, 660, 200 + move, 416, ChunkyPNG::Color.rgb(0, 0, 0),
               ChunkyPNG::Color.rgb(255, 40, 0))
  end

  def self.draw_one_grade_block(image, move)
    image.rect(150 + move, 660, 200 + move, 538, ChunkyPNG::Color.rgb(0, 0, 0),
               ChunkyPNG::Color.rgb(255, 0, 0))
  end
end
