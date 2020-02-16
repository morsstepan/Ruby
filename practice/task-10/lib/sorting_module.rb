require_relative 'person'
require_relative 'group'
# A basic module for sorting people
module SortingModule
  def self.people_by_surname(people)
    sorted_by_surname = people.people.sort_by(&:surname)
    sorted_by_surname = sorted_by_surname.group_by(&:surname).keep_if do |_, e|
      e.length > 1
    end
    sorted_by_surname
  end

  def self.people_by_month(people)
    sorted_by_month = people.people.sort_by(&:birth_month)
    sorted_by_month = sorted_by_month.group_by(&:birth_month).keep_if do |_, e|
      e.length > 1
    end
    sorted_by_month
  end

  def self.people_by_year(people)
    people.people.sort_by(&:birth_year)
    sorted_by_year = people.people.select do |person|
      check_year(person)
    end
    sorted_by_year
  end

  def self.check_year(person)
    if person.sex == 'male'
      Date.today.year - person.birth_year >= 60
    else
      Date.today.year - person.birth_year >= 55
    end
  end
end
