##
# A class for an adress
class Adress
  attr_accessor :district, :street, :number
  def initialize(district, street, number)
    @district = district
    @street = street
    @number = number
  end

  def district_to_s
    @district.to_s + ' district'
  end

  def street_to_s
    @street.to_s + ' street'
  end

  def number_to_s
    @number.to_s
  end

  def return_adress
    district_to_s + ', ' + street_to_s + ', ' + number_to_s
  end
end
