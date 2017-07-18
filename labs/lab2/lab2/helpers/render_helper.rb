require_relative '../models/models'

##
# Module provides methods to display model elements on the web pages
module RenderHelper
  def short_apartment_info(apartment)
    "Apartment # #{apartment[:index] + 1}" + "\n" \
      "Footage: #{apartment[:data].footage}" + "\n" \
      "Rooms: #{apartment[:data].number_of_rooms}" + "\n"
  end

  ##
  # Convert location to a human-readable string
  def humanize_location(location)
    Meter::LOCATIONS[location]
  end

  ##
  # Convert meter type to a human-readable string
  def humanize_meter_type(type)
    Meter::TYPES[type]
  end

  ##
  # Specify some methods to be private
  class << self
    # Add code here
  end
end
