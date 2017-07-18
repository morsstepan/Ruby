##
# Класс описывает количество денег
class Money
  attr_reader :amount, :currency

  ##
  # Для описания объекта необходимо указать
  #
  # +amount+ объём доступной валюты
  # +currency+ название валюты
  #
  # Инициализатор может выбросить исключение, если данные переданы некорректно
  def initialize(amount, currency)
    raise "Illegal amount: [#{amount}]" if amount < 0
    raise "Illegal currency: [#{currency}]" if currency.nil? || currency.empty?
    @amount = amount
    @currency = currency
  end

  ##
  # Метод для сравнения экземпляров класса друг с другом
  def ==(other)
    return false if other.class != Money
    other.amount == amount && other.currency == currency
  end
end
