require_relative 'helper'
# A test for apartments
class TestApartments < Minitest::Test
  def setup
    @adress = Adress.new('Zavolzhsky', 'Saukova', '12')
    @conditions = ExchangeConditions.new('Zavolzhsky', 'Saukova', '12')
    @apartment = Apartment.new('30', '1', @adress, '1',
                               'brick', '5', '1200000', @conditions)
    @apartments = Apartments.new([@apartment])
  end

  def test_initialize
    result = [{ index: 0, data: @apartment }]
    assert_equal(result, @apartments.apartments)
  end

  def test_add
    @apartments << @apartment
    result = [{ index: 0, data: @apartment }, { index: 1, data: @apartment }]
    assert_equal(result, @apartments.apartments)
  end

  def test_current_amount
    result = [{ index: 0, data: @apartment }]
    assert_equal(result.size, @apartments.current_amount)
  end

  def test_return
    result = [{ index: 0, data: @apartment }]
    assert_nil(result[1], @apartments[1])
  end

  def test_return_apartments
    result = [@apartment]
    assert_equal(result, @apartments.return_apartments)
  end

  def test_apartments
    result = [{ index: 0, data: @apartment }]
    assert_equal(result, @apartments.apartments)
  end

  def test_page_count
    result = '1'
    assert_equal(result, @apartments.page_count.to_s)
  end

  def test_page_count_else
    result = '0'
    @apartments.delete(0)
    assert_equal(result, @apartments.page_count.to_s)
  end

  def test_delete
    result = []
    @apartments.delete(0)
    assert_equal(result, @apartments.apartments)
  end

  def test_sort_by_district
    good_result = @apartments
    @apartments.sort_by_district
    assert_equal(good_result, @apartments)
  end

  def test_sort_by_rooms
    good_result = @apartments
    @apartments.sort_by_rooms
    assert_equal(good_result, @apartments)
  end

  def test_sort_by_price
    good_result = @apartments.return_apartments
    result = @apartments.sort_by_price(1, 3_000_000)
    assert_equal(good_result, result)
  end
end
