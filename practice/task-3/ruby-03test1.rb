require 'yaml'
require_relative 'Student'
require_relative 'Course'
def process_raw_students(raw_students)
    raw_students.map do |raw_student|
        Student.new(raw_student["id"], raw_student["name"], raw_student["education_year"])
    end                
end
def process_raw_courses(raw_courses, students)
	raw_courses.map do |raw_course|
		if(raw_course["grades"].nil?)
			Course.new(raw_course["name"])
		else
			grades = raw_course["grades"].map do |student_and_grade|
				grades = student_and_grade
			end
			Course.new(raw_course["name"], grades)
		end
	end
end
def print_line
	puts '-' * 40
end
def show_courses(courses, students)
    courses.each do |course| 
    	puts result = avg_grade(course, students)
    end
end
def avg_grade(course, students)
	avg = 0.0
	sum = 0
	course.grades.each do |grades| 
		sum += grades["grade"].to_f
		#p sum
	end
	if (course.grades.size != 0)
		avg = sum / course.grades.size
	end
	if(avg == 0)
		result = "There are no grades at the " + course.name.to_s + " course"
	else
    	result = "GPA is " + avg.round(2).to_s + " at the " + course.name.to_s + " course"
    end
end
def choose_course_for_showing_grades(courses, students)
	puts "Available courses are: "
	courses.each do |course|
		puts "- " + course.name.to_s
	end
	puts "Choose the course, please"
	puts "You have to write a course name (for example, 'Ethics')"
	puts "You have choosen " + choose = $stdin.gets.strip	
	error = false
	courses.each do |course| 
		if(choose == course.name) 
			error = (choose == course.name)
		end
	end
	if(error == true) 
	    if(error) 
			show_grades(courses, students, choose)
		end 	
	else
		puts "You have written an incorret course name.\nPlease, pay attention on the available courses"
    end    
end
def show_grades(courses, students, course_name)
	print_line
	#puts "Ivan was here"
	courses.each do |course|
		#p course
		students.each do |student|
			if((course.grades.empty?) and (course.name == course_name))
						puts "There are no grades and students at the " + course.name + " course"
						break
			else
				course.grades.each do |grades| #puts "Natalia was here"
					if((course.name == course_name) and (student.id == grades["student_id"]))	
						result = student.name.to_s+"'s grade at the " + course_name + " course is " + grades["grade"].to_s
						puts result
					end
				end
			end
		end
	end
end
def save_changes(courses, students)
	puts "Do you want save changes and exit from a program? (y/n)"
	choose = $stdin.gets.strip
	case(choose)
	when "y" 
	    data_c = courses
	    data_s = students
	    #data_c = students.map do |student|
	    #	student.id
	    #	student.name
	    #	student.education_year
	    #end
	    #p data_c
		#end
	    puts "Saved to #{"new"+ARGV[0]}"
	    File.open("new"+ARGV[0], 'w+') { |f| YAML.dump(data_s, f) }
	    File.open("new"+ARGV[0], 'a') { |f| YAML.dump(data_c, f) }
	when "n"
		main_menu(courses, students)
	else
		puts "error!"
	end
end
def clear_console
	system "cls"
	system "clear"
end
def give_grade(courses, students)
	print_line
	puts "Students are: "
	students.each do |student|
		puts "- #{student.name}"
	end
	print_line
	puts "Choose the student for adding a grade"
	puts "You have to write a name (for example, 'Ivan')"
	print_line
	error = false
	puts "You have choosen " + choose = $stdin.gets.strip	
	students.each do |student| 
		if(error = (student.name == choose)) 
			break
		end
	end
	if(error == true)
		choose_course(courses, students, choose)
	else
		puts "You have written an incorret name. Please, pay attention on the students"
	end
end
def choose_course(courses, students, student_name)
	puts "Courses are: "
	print_line
	courses.each do |course|
		puts "- " + course.name.to_s
	end
	puts "Choose the course for adding a grade"
	puts "You have to write a course name (for example, 'Ethics')"
	print_line
	puts "You have choosen " + choose = $stdin.gets.strip	
	error = false
	courses.each do |course| 
		if(choose == course.name) 
			error = (choose == course.name)
		end
	end
	if(error == true) 
    	courses.each do |course|
    		if(course.name == choose) 
    			student_id = -1
				students.each do |student| 
					if(student_name == student.name)
						student_id = student.id
					end
				end
    			choose_grade(courses, students, student_id, choose)
			end 	
	    end
	else
		puts "You have written an incorret course. Please, pay attention on the available courses"
    end  
end
def if_grade_exists(courses, students, student_id, course_name, mark)
	courses.each do |course|
		students.each do |student|
			if((course.grades.empty?) and (student.id == student_id) and (course_name == course.name))
				input = {"student_id" => student_id, "grade" => mark} 
				course.grades.push(input)
			else
				if(student.id == student_id) and (course_name == course.name) 
					course.grades.each do|grades|
						if(grades["student_id"] == student_id)
							puts "A grade (#{grades["grade"]})for #{student.name} already exists.\nDo you want to rewrite it?(y/n)"
							choice = $stdin.gets.strip
							case(choice)
							when 'y'
								grades["grade"] = mark
								main_menu(courses, students)
							when 'n'
								main_menu(courses, students)
							else 
								puts "Error! Check your input data, please."
								main_menu(courses, students)
							end
						end
					end
				end
			end
		end
	end
end
def choose_grade(courses, students, student_id, course_name)
	puts "Input a grade: "
	mark = choose = $stdin.gets.to_i # ввод оценки
	if(mark.negative?)
		puts "Error! A grade cannot be negative"
	else
		if_grade_exists(courses, students, student_id, course_name, mark)
		p course_name
	end
end
def main_menu(courses, students)
	puts "This program is created for working with base of students and their grades \n"
    puts "You have to enter a number for choosing the option \n"
    puts "[1] Show the courses and GPA (Grade Point Average)\n"
    puts "[2] Show current grades of students on the selected subject \n"
    puts "[3] To give a grade to the already known student\n"
    #puts "[4] Add the new subject\n"
    puts "[4] Save changes and exit\n"
	choose = $stdin.gets.to_i
	case(choose)
	when 1
		clear_console
		puts "You have selected the option #1"
		print_line
		show_courses(courses, students)
		print_line
		main_menu(courses, students)
	when 2
		clear_console
		puts "You have selected the option #2"
		print_line
		choose_course_for_showing_grades(courses, students)
		print_line
		main_menu(courses, students)
	when 3
		clear_console
		puts "You have selected the option #3"
		give_grade(courses, students)
		main_menu(courses, students)
	#when 4
	#	# Добавлять новые предметы к списку.
	#	puts "You have selected the option #4"
	#	main_menu(courses, students)
	when 4
		save_changes(courses, students)
	else
        puts "Error! Check your input data, please."
        main_menu(courses, students)
	end

end
def process_file(file_name)
	file_data = File.read(file_name)
    data = YAML.load(file_data)
    #p data
    students = process_raw_students(data["students"])
    courses = process_raw_courses(data["courses"], students)
    main_menu(courses, students)
    #p courses
    #ARGV.clear
end
def read_data
	unless ARGV.empty?
    	data = process_file(ARGV[0])
    else
    	puts "Please, specify data file."
    end
end
def main
	read_data
end
main
