##
# A basic class for computer repo
class Apartments
  PAGE_SIZE = 5

  def initialize(apartments = [])
    @apartments = apartments
  end

  def <<(apartment)
    @apartments << apartment
  end

  def current_amount
    @apartments.size
  end

  def [](index)
    @apartments[index]
  end

  def return_apartments
    @apartments
  end

  def apartments(page = 0)
    @apartments[page * PAGE_SIZE, PAGE_SIZE].map.with_index do |apart, index|
      {
        index: page * PAGE_SIZE + index,
        data: apart
      }
    end
  end

  def page_count
    if @apartments.size % PAGE_SIZE != 0
      @apartments.size / PAGE_SIZE + 1
    else
      @apartments.size / PAGE_SIZE
    end
  end

  def delete(index)
    @apartments.delete_at(index)
  end

  def sort_by_district
    @apartments = @apartments.sort_by do |apartment|
      apartment.adress.district
    end
  end

  def sort_by_rooms
    @apartments = @apartments.sort_by(&:number_of_rooms)
  end

  def sort_by_price(from, to)
    sorted_apartments = @apartments.select do |apartment, _index|
      (apartment.price.to_i >= from) && (apartment.price.to_i <= to)
    end
    sorted_apartments
  end
end
