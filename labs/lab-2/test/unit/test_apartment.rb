require_relative 'helper'
# A test for an apartment
class TestApartment < Minitest::Test
  def setup
    @adress = Adress.new('Zavolzhsky', 'Saukova', '12')
    @conditions = ExchangeConditions.new('Zavolzhsky', 'Saukova', '12')
    @apartment = Apartment.new('30', '1', @adress, '1',
                               'brick', '5', '1200000', @conditions)
  end

  def test_initialize
    result = { footage: '30', number_of_rooms: '1',
               adress: @adress }
    assert_equal([result[:footage], result[:number_of_rooms],
                  result[:adress]], [@apartment.footage,
                                     @apartment.number_of_rooms,
                                     @apartment.adress])
  end
end
