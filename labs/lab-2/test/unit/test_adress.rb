require_relative 'helper'
# Test for an adress
class TestAdress < Minitest::Test
  def setup
    @adress = Adress.new('Zavolzhsky', 'Saukova', '12')
  end

  def test_initialize
    result = { district: 'Zavolzhsky', street: 'Saukova',
               number: '12' }
    assert_equal([result[:district], result[:street], result[:number]],
                 [@adress.district, @adress.street, @adress.number])
  end

  def test_district_to_s
    result = 'Zavolzhsky district'
    assert_equal result, @adress.district_to_s
  end

  def test_street_to_s
    result = 'Saukova street'
    assert_equal result, @adress.street_to_s
  end

  def test_number_to_s
    result = '12'
    assert_equal result, @adress.number_to_s
  end

  def test_return_adress
    result = 'Zavolzhsky district, Saukova street, 12'
    assert_equal result, @adress.return_adress
  end
end
