require_relative 'helper'

class TestGroup < Minitest::Test
  def setup
    @person = Person.new('Nikolaev', 'Alexey', 'Vasilievich', 'male',
                         30, 11, 1987, 'Moscow')
    @person_two = Person.new('Nikolaev', 'Andrey', 'Vasilievich', 'male',
                             11, 0o3, 1999, 'Yaroslavl')
    @person_three = Person.new('Morozova', 'Natalia', 'Vasilievivna', 'female',
                               3, 0o7, 1997, 'Yaroslavl')
    @people = Group.new([@person,
                         @person_two,
                         @person_three])
  end

  def test_initialize
    result = [@person, @person_two, @person_three]
    assert_equal(result, @people.people)
  end

  def test_add
    result = [@person, @person_two, @person_three]
    result << @person
    @people << @person
    assert_equal(result, @people.people)
  end

  def test_current_amount
    result = [@person, @person_two, @person_three]
    assert_equal result.size, @people.current_amount
  end

  def test_get_element
    result = [@person, @person_two, @person_three]
    assert_equal result[1], @people[1]
  end

  def test_delete
    result = [@person, @person_two, @person_three]
    result.delete_at(2)
    @people.delete(2)
    assert_equal result, @people.people
  end
end
