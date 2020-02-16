require_relative 'person'
require_relative 'group'
# A basic module for saving people in the file
module SavingModule
  def self.save_people_by_surname(people)
    sorted_by_surname = people.people.sort_by(&:surname)
    sorted_by_surname = sorted_by_surname.group_by(&:surname).keep_if do |_, e|
      e.length > 1
    end
    File.open('results/sorted_by_surname', 'w+') do |file_name|
      file_name.write('Namesakes: ' + "\n")
      sorted_by_surname.each do |row|
        row[1].each { |person| file_name.write(person.return_person) }
      end
    end
  end

  def self.save_people_by_month(people)
    sorted_by_month = people.people.sort_by(&:birth_month)
    sorted_by_month = sorted_by_month.group_by(&:birth_month).keep_if do |_, e|
      e.length > 1
    end
    File.open('results/sorted_by_month', 'w+') do |file_name|
      file_name.write('Born in the same month: ' + "\n")
      sorted_by_month.each do |row|
        row[1].each { |person| file_name.write(person.return_person) }
      end
    end
  end

  def self.save_people_by_year(people)
    people.people.sort_by(&:birth_year)
    sorted_by_year = people.people.select do |person|
      check_year(person)
    end
    File.open('results/retirees', 'w+') do |file_name|
      file_name.write('Retirees: ' + "\n")
      sorted_by_year.each { |person| file_name.write(person.return_person) }
    end
  end

  def self.check_year(person)
    if person.sex == 'male'
      Date.today.year - person.birth_year >= 60
    else
      Date.today.year - person.birth_year >= 55
    end
  end
end
