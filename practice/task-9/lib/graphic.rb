##
# Класс предназначен для вычисления значений функции на отрезке.
class Graphic
  attr_reader :width, :height

  ##
  # Создаёт новый объект типа график
  #
  # +width+ указывает количество столбцов для отображения графика
  # +height+ указывает количество строк для отображения графика
  def initialize(width, height)
    @width = Integer(width)
    @height = Integer(height)
  end

  ##
  # Вычисляет значение функции на отрезке для отображения на графике.
  # Шаг отображения определяется исходя из ширины графика.
  #
  # +start+ начало промежутка
  # +stop+ окончание промежутка
  # +block+ ассоциированный блок должен вычислять значение функции
  #
  # Метод возвращает массив значений функции.
  def calculate_values(start, stop)
    step_size = calculate_step_size(start, stop, @width)
    @width.times.to_a.map do |step|
      yield step * step_size + start
    end
  end

  ##
  # Формирует список строк, которые составят изображение графика
  #
  # +start+ указывает начало промежутка
  # +stop+ указывает окончание промежутка
  # +block+ ассоциированный блок должен вычислять значения функции
  #
  # Метод возвращает массив строк функции.
  def draw_funciton(start, stop, &block)
    values = calculate_values(start, stop, &block)
    minimum = values.min
    step_size = calculate_step_size(minimum, values.max, @height)
    @height.times.to_a.map do |line|
      # Ошибка была в строке с переменной step_start
      step_start = minimum + line
      step_end = step_start + step_size * 0.99
      draw_line(step_start, step_end, values)
    end.reverse
  end

  private

  ##
  # Метод вычисляет размер шага для построения сетки
  #
  # +start+ указывает начало промежутка
  # +stop+ указывает окончание промежутка
  # +points+ указывает количество точек, необходимых
  # для построения точек
  #
  # Возвращает размер шага
  def calculate_step_size(start, stop, points)
    (stop - start) / (points - 1).to_f
  end

  ##
  # Метод преобразует набор значений в функции в строку
  #
  # +start+ начало промежутка
  # +stop+ окончание промежутка
  # +values+ набор значений функции
  #
  # Возвращает строку, соответствующую данным значениям
  def draw_line(start, stop, values)
    values.map do |value|
      value.between?(start, stop) ? 'X' : '0'
    end.join
  end
end
