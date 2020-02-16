require_relative 'additional_models'
require_relative 'models'
##
# A module for calculating
module CalculatingModule
  def self.change_adress(apartment, params)
    apartment.adress.district = params['adress_district']
    apartment.adress.street = params['adress_street']
    apartment.adress.number = params['adress_number']
  end

  def self.change_conditions(apartment, params)
    apartment.exchange_conditions.district = params['condition_district']
    apartment.exchange_conditions.street = params['condition_street']
    apartment.exchange_conditions.floor = params['condition_floor']
  end

  def self.change_apartment(apartment, params)
    apartment.footage = params['footage']
    apartment.number_of_rooms = params['number_of_rooms']
    apartment.floor = params['floor']
    apartment.type = params['type']
    apartment.number_of_floors = params['number_of_floors']
    apartment.price = params['price']
  end

  def self.change(apartment, params)
    change_adress(apartment, params)
    change_apartment(apartment, params)
    change_conditions(apartment, params)
  end

  def self.how_much_money(apartment, current_apartment)
    additional_price = apartment.price.to_i - current_apartment.price.to_i
    return 0 if additional_price < 0
    return additional_price if additional_price > 0
  end

  def self.check_floor(wanted_ap, cur_ap)
    cur_ap.exchange_conditions.floor == wanted_ap.floor &&
      wanted_ap.exchange_conditions.district == cur_ap.adress.district
  end

  def self.check_street(wanted_ap, cur_ap)
    cur_ap.exchange_conditions.street == wanted_ap.adress.street &&
      wanted_ap.exchange_conditions.street == cur_ap.adress.street
  end

  def self.check_district(wanted_ap, cur_ap)
    cur_ap.exchange_conditions.district == wanted_ap.adress.district &&
      wanted_ap.exchange_conditions.district == cur_ap.adress.district
  end

  def self.check_offers(wanted_ap, cur_ap)
    check_district(wanted_ap, cur_ap) && check_street(wanted_ap, cur_ap) &&
      check_floor(wanted_ap, cur_ap)
  end

  def self.page(params)
    if params['page']
      params['page'].to_i
    else
      0
    end
  end

  def self.search(apartments, current_apartment)
    sorted_apartmens = Apartments.new
    apartments.each do |apartment|
      next unless check_offers(apartment, current_apartment) == true
      apartment.surcharge = how_much_money(apartment, current_apartment)
      sorted_apartmens.return_apartments << apartment
    end
    sorted_apartmens
  end

  def self.create_adress(params)
    Adress.new(params['adress_district'],
               params['adress_street'],
               params['adress_number'])
  end

  def self.create_conditions(params)
    ExchangeConditions.new(params['condition_district'],
                           params['condition_street'],
                           params['condition_floor'])
  end

  def self.create_apartment(params)
    Apartment.new(params['footage'],
                  params['number_of_rooms'],
                  create_adress(params),
                  params['floor'],
                  params['type'],
                  params['number_of_floors'],
                  params['price'],
                  create_conditions(params))
  end
end
