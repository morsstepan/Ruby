require_relative 'helper'

class TestPerson < Minitest::Test
  def setup
    @person = Person.new('Nikolaev', 'Alexey', 'Vasilievich', 'male',
                         30, 11, 1987, 'Moscow')
  end

  def test_initialize
    result = { surname: 'Nikolaev', name: 'Alexey',
               patronymic: 'Vasilievich', sex: 'male', birth_day: 30,
               birth_month: 11, birth_year: 1987, city: 'Moscow' }
    assert_equal([result[:surname], result[:name], result[:patronymic],
                  result[:sex], result[:birth_day], result[:birth_month]],
                 [@person.surname, @person.name, @person.patronymic,
                  @person.sex, @person.birth_day,
                  @person.birth_month])
  end

  def test_name_to_s
    result = 'Full name: Nikolaev Alexey Vasilievich' + "\n"
    assert_equal result, @person.name_to_s
  end

  def test_sex_to_s
    result = 'Sex: male' + "\n"
    assert_equal result, @person.sex_to_s
  end

  def test_date_of_birth_to_s
    result = 'Date of birth: 30.11.1987' + "\n"
    assert_equal result, @person.date_of_birth_to_s
  end

  def test_city_to_s
    result = 'City: Moscow' + "\n"
    assert_equal result, @person.city_to_s
  end

  def test_line_to_s
    result = '---------------' + "\n"
    assert_equal result, @person.line_to_s
  end

  def test_return_person
    result =
      'Full name: Nikolaev Alexey Vasilievich' + "\n" \
      'Sex: male' + "\n" \
      'Date of birth: 30.11.1987' + "\n" \
      'City: Moscow' + "\n" \
      '---------------' + "\n"
    assert_equal result, @person.return_person
  end
end
