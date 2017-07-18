require_relative 'helper'
##
# Tests for the main flat page operations
class TestApartment < MiniTest::Test
  include Capybara::DSL

  def setup
    @app = ApartmentStore.new
    Capybara.app = @app
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def test_there_is_content
    visit '/apartments'
    assert page.has_content?('Select'), 'Buttons need to be added'
  end

  def test_add
    visit '/apartments'
    click_on('Add')
    fill_in('Footage:', with: '133')
    fill_in('District:', with: 'test', match: :first)
    fill_in('Number of rooms:', with: '3')
    fill_in('Number:', with: '11111')
    click_on('Send')
    click_on('Page 3')
    assert page.has_content?('Adress')
  end

  def test_about
    visit('/about')
    assert page.has_content?('Morozov Stepan')
  end

  def test_sort_by_district
    visit '/apartments'
    # click_on('Sort by district')
    # assert !page.has_content?('Neftestroy')
  end

  def test_sort_by_rooms
    visit '/apartments'
    # click_on('Sort by rooms')
    # assert page.has_content?('Zavolzhsky district, Souznaya street, 4 floor')
  end

  def test_sort_by_price
    visit '/apartments'
    # click_on('Sort by price')
    # fill_in('From', with: 1)
    # fill_in('To', with: 1_200_000)
    # click_on('Sort')
    # assert page.has_content?('Neftestroy')
  end

  def test_search
    visit '/apartments'
    click_on('Select', match: :first)
    click_on('Search for an offer')
    assert page.has_content?('Adress')
  end

  def test_delete
    visit '/apartments'
    click_on('Select', match: :first)
    click_on('Delete')
    assert !page.has_content?('Urickogo street, 1 floor ')
  end

  def test_edit
    visit '/apartments'
    click_on('Select', match: :first)
    click_on('Edit')
    fill_in('Footage:', with: '133')
    fill_in('District:', with: 'test', match: :first)
    fill_in('Number of rooms:', with: '3')
    fill_in('Number:', with: '11111')
    click_on('Send')
    assert !page.has_content?('Saukova street, 12 ')
  end
end
