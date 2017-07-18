##
# A class for an apartment
class Apartment
  attr_accessor :footage, :number_of_rooms, :adress, :floor, :type,
                :number_of_floors, :price, :surcharge, :exchange_conditions
  def initialize(footage, number_of_rooms, adress, floor, type,
                 number_of_floors, price, exchange_conditions, surcharge = 0)
    @footage = footage
    @number_of_rooms = number_of_rooms
    @adress = adress
    @floor = floor
    @type = type
    @number_of_floors = number_of_floors
    @price = price
    @surcharge = surcharge
    @exchange_conditions = exchange_conditions
  end

  # List of know meter types
  TYPES = {
    panel: 'Panel',
    brick: 'Brick'
  }.freeze
end
