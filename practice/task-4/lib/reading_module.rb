require 'yaml'
require_relative 'student'
require_relative 'course'
# A base module for reading operations
module ReadingModule
  def self.process_raw_students(raw_students)
    raw_students.map do |raw_student|
      Student.new(raw_student['id'], raw_student['name'],
                  raw_student['education_year'])
    end
  end

  def self.create_course_without_student_id(raw_course)
    Course.new(raw_course['name'])
  end

  def self.create_course_with_student_id(raw_course, students)
    grades = raw_course['grades'].map do |student_and_grade|
      { student_id: students.find do |student|
        student.id == student_and_grade['student_id']
      end,
        grade: student_and_grade['grade'] }
    end
    Course.new(raw_course['name'], grades)
  end

  def self.process_raw_courses(raw_courses, students)
    raw_courses.map do |raw_course|
      if raw_course['grades'].nil?
        create_course_without_student_id(raw_course)
      else
        create_course_with_student_id(raw_course, students)
      end
    end
  end

  def self.check_student(student)
    puts 'Wrong input data! ' if validation(student.id)
    exit if validation(student.id) || validation(student.education_year)
    puts 'Wrong input data! ' if validation(student.education_year)
    exit if validation(student.education_year)
  end

  def self.check_course(course)
    course.grades.each do |grades|
      puts 'Wrong data!' if validation grades[:grade]
      exit if validation grades[:grade]
    end
  end

  def self.check_input_data(data)
    students = process_raw_students(data['students'])
    courses = process_raw_courses(data['courses'], students)
    students.each { |student| check_student(student) }
    courses.each { |course| check_course(course) }
  end

  def self.validation(a)
    !Integer(a)
  rescue
    puts "A file has unexpected symbol '#{a}'!"
    return true
  end

  def self.read_data
    if ARGV.empty?
      puts 'Please, specify data file.'
      exit
    else
      data = process_file
    end
    data
  end

  def self.file_empty?(file_name)
    puts "A file #{file_name} is empty\n" if File.zero?(file_name)
    exit if File.zero?(file_name)
  end

  def self.file_exists?(file_name)
    puts "Error! A file #{file_name} not found!" unless File.exist?(file_name)
    exit unless File.exist?(file_name)
  end

  def self.check_file(file_name)
    file_exists?(file_name)
    file_empty?(file_name)
  end

  def self.process_file
    ARGV.each do |file_name|
      check_file(file_name)
      file_data = File.read(file_name)
      data = YAML.safe_load(file_data)
      check_input_data(data)
      return data
    end
  end
end
