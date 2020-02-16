require_relative 'helper'
# Test for an adress
class TestConditions < Minitest::Test
  def setup
    @conditions = ExchangeConditions.new('Zavolzhsky', 'Saukova', '12')
  end

  def test_initialize
    result = { district: 'Zavolzhsky', street: 'Saukova',
               floor: '12' }
    assert_equal([result[:district], result[:street], result[:floor]],
                 [@conditions.district, @conditions.street, @conditions.floor])
  end

  def test_district_to_s
    result = 'Zavolzhsky district'
    assert_equal result, @conditions.district_to_s
  end

  def test_street_to_s
    result = 'Saukova street'
    assert_equal result, @conditions.street_to_s
  end

  def test_floor_to_s
    result = '12 floor'
    assert_equal result, @conditions.floor_to_s
  end

  def test_return_conditions
    result = 'Zavolzhsky district, Saukova street, 12 floor'
    assert_equal result, @conditions.return_conditions
  end
end
