class Student
    attr_reader :id, :name, :education_year
    def initialize(id, name, education_year)
        @id = id
        @name = name
        @education_year = education_year
    end
    def <<(student)
        @students << student
        self
    end   
    
end