class Course
    attr_reader :name, :grades

    def initialize(name, grades = [])
        @name = name
        @grades = grades
    end
    def to_s
    	"#{@name}: #{@grades.join(", ")}"
    end
end