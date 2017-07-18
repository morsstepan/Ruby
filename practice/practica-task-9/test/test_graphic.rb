require 'minitest/test'
require 'graphic'

class TestGraphic < Minitest::Test
  def setup
    @graphic = Graphic.new(5, 5)
  end

  ##
  # Тест должен проверять, что метод calculate_values предоставляет
  # необходимое количество элементов в массиве
  def test_calculate_step_count
    # Тест
    # p @graphic.calculate_values(5,5) {|value| value}
    assert_equal(5, @graphic.calculate_values(1, 5) { |value| value }.size)
  end

  ##
  # Тест должен проверять, что метод calculate_values предоставляет
  # значения метода value у функции, которая была вызвана
  def test_calculate_correct_call_on_every_step
    assert @graphic.calculate_values(1, 5) { |value|
      !value.nil?
    }.include?(true)
    # p @graphic.calculate_values(1,5) {|value| !value.nil?}
    # Тест
  end

  ##
  # Тест должен проверять, что функция высчитывает корректные значения
  # для всех контрольных точек
  def test_calculate_correct_values_on_every_step
    result = [1.0, 2.0, 3.0, 4.0, 5.0]
    # second_graphic = Graphic.new(3, 5)
    # Тест
    assert_equal result,
                 @graphic.calculate_values(1, 5) { |value| value }
  end

  ##
  # Тест должен проверять, что метод draw_function возвращает нужное
  # количество строк
  def test_draw_calculate_rows_count
    rows = @graphic.draw_funciton(1, 5) { |value| value }.size
    assert_equal(rows, @graphic.height)
    # Добавьте тест
  end

  ##
  # Тест должен проверять, что метод draw_function возвращает правильные
  # строки для диагонали
  def test_draw_transparent_function
    result = %w[0000X 000X0 00X00 0X000 X0000]
    assert_equal(result,
                 @graphic.draw_funciton(1, 5) do |value|
                   Functions::LINEAR.call(value)
                 end)
    # p @graphic.draw_funciton(1, 5){|value| Functions::LINEAR.call(value)}
    # Тест
  end

  ##
  # Тест должен проверять, что метод draw_function корректно отображает
  # константу
  def test_draw_constant_function
    # Тест
    result = %w[00000 00000 00000 00000 XXXXX]
    assert_equal(result,
                 @graphic.draw_funciton(1, 5) do |value|
                   Functions::CONSTANT.call(value)
                 end)
    # p @graphic.draw_funciton(1, 5){|value| Functions::CONSTANT.call(value)}
  end
end

##
# Модуль содержит функции, используемые в тестах
module Functions
  CONSTANT = ->(_) { 1 }
  LINEAR = ->(x) { x }
end
