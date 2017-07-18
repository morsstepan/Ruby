require 'minitest/unit'
require 'polynomial'

##
# Класс для тестирования класса многочлен
class TestPolynomial < Minitest::Test
  # Тест проверяет, что аргументы, переданные в конструктор,
  # сохраняются в экземпляре класса
  def setup
    @polynomial = Polynomial.new([-3, 5, 3])
  end

  def test_arguments_are_saved
    result = {
      coefficients: [-3, 5, 3]
    }
    assert_equal(result[:coefficients], @polynomial.coefficients,
                 'Needs to be equal')
  end

  def test_to_string
    result = '-3x^2 + 5x + 3'
    assert_equal(result, @polynomial.to_s, 'Needs to be equal')
  end

  def test_degree
    result = 2
    assert_equal(result, @polynomial.degree, 'Needs to be equal')
  end

  def test_value
    result = -6297
    assert_equal(result, @polynomial.value(-45), 'Needs to be equal')
  end
end
