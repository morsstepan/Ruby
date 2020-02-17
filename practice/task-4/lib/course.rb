# A base class for a course
class Course
  attr_reader :name, :grades
  def initialize(name, grades = [])
    @name = name
    @grades = grades
  end
end
