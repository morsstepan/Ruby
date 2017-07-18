require 'minitest/unit'
require 'money'

class TestMoney < Minitest::Test
  def setup
    @money = Money.new(100, 'EUR')
    # Поместите общую логику тестов сюда
  end

  ##
  # Тест проверяет, что аргументы, переданные в конструктор,
  # сохраняются в экземпляре класса
  def test_arguments_are_saved
    # right_money = { amount: 5000, currency: 'Dollar' }
    # checked_money = { amount: @money.amount, currency: @money.currency }
    # assert_equal right_money, checked_money
    assert_equal(100, @money.amount)
    assert_equal('EUR', @money.currency)
  end

  ##
  # Тест, проверяющий, что два объекта с одинаковыми наборами
  # данных будут равны друг другу
  def test_equal_object_are_equal
    second_money = Money.new(100, 'EUR')
    assert(@money == second_money, 'Needs to be equal')
  end

  ##
  # Тест, проверяющий, что два объекта с разными наборами данных
  # будут неравны друг другу. Можно добавить проверку на сравнение
  # с другими объектами
  def test_distinct_object_are_not_equal
    second_money = Money.new(100, 'USD')
    assert(@money != second_money, 'False, objects are not equal')
  end

  ##
  # Тест, проверяющий, что при передаче неправильных аргументов
  # в конструктор объекта будут вызваны исключения
  def test_wrong_instatiation_raises_exception
    assert_raises RuntimeError do
      Money.new(-3, 'EUR')
      Money.new(3, 24)
      Money.new(3)
    end
    # Добавьте тест
  end
end
