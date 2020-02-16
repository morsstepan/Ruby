##
# A class for exchange conditions
class ExchangeConditions
  attr_accessor :district, :street, :floor
  def initialize(district, street, floor)
    @district = district
    @street = street
    @floor = floor
  end

  def district_to_s
    @district.to_s + ' district'
  end

  def street_to_s
    @street.to_s + ' street'
  end

  def floor_to_s
    @floor.to_s + ' floor'
  end

  def return_conditions
    district_to_s + ', ' + street_to_s + ', ' + floor_to_s
  end
end
