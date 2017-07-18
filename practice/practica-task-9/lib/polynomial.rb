##
# Класс позволяет описать многочлен
class Polynomial
  attr_reader :coefficients

  ##
  # Создаёт класс многочлен, который описывается набором
  # коэффициентов. Самый младший коэффициент указывается в конце
  # массива.
  def initialize(coefficients)
    @coefficients = coefficients.drop_while(&:zero?)
  end

  ##
  # Преобразует многочлен к строке к виду
  # 5x^3 + 6x^2 + 3
  def to_s
    parts = @coefficients.map.with_index do |coefficient, index|
      next if coefficient.zero?
      coef_string = coefficient == 1 ? '' : coefficient.to_s
      coef_string + degree_string(degree - index)
    end
    parts.reject(&:nil?).join(' + ')
  end

  ##
  # Метод возвращает степень многочлена
  def degree
    @coefficients.size - 1
  end

  ##
  # Метод вычисляет значение многочлена в точке
  def value(point)
    result = 0
    temp_degree = degree
    for i in 0..degree
      temp = (point**temp_degree) * @coefficients[i]
      temp_degree -= 1
      result += temp
    end
    result
  end

  private

  ##
  # Возвращает строку, описывающую элемент многочлена
  def degree_string(element_degree)
    case element_degree
    when 0
      ''
    when 1
      'x'
    else
      "x^#{element_degree}"
    end
  end
end
