require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'models/models'
require_relative 'models/additional_models'
require_relative 'helpers/helpers'
# require_relative 'sort'

##
# A sinatra application class
class ApartmentStore < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :apartments, ReadingModule.read_data

  helpers RenderHelper

  get '/' do
    @amount = settings.apartments.current_amount
    erb :index
  end

  get '/apartments' do
    page = CalculatingModule.page(params)
    @apartments_with_index = settings.apartments.apartments(page)
    @page_count = settings.apartments.page_count
    erb :apartments
  end

  get '/apartments/new' do
    erb :new
  end

  post '/apartments' do
    apart = CalculatingModule.create_apartment(params)
    apartment_id = params['apartment_id'].to_i
    @apartment = settings.apartments[apartment_id]
    settings.apartments << apart
    redirect to('/apartments')
  end

  get '/apartments/:apartment_id' do
    apartment_id = params['apartment_id'].to_i
    @apartment = settings.apartments[apartment_id]
    erb :apartment
  end

  get '/apartments/:apartment_id/delete' do
    apartment_id = params['apartment_id'].to_i
    settings.apartments.delete(apartment_id)
    redirect to('/apartments')
  end

  post '/apartments/:apartment_id/edit' do
    apartment_id = params['apartment_id'].to_i
    @apartment = settings.apartments[apartment_id]
    CalculatingModule.change(@apartment, params)
    redirect to('/apartments')
  end

  get '/apartments/:apartment_id/edit' do
    apartment_id = params['apartment_id'].to_i
    @apartment = settings.apartments[apartment_id]
    erb :editor
  end

  post '/apartments/:apartment_id/search/results' do
    apartment_id = params['apartment_id'].to_i
    @apartment = settings.apartments[apartment_id]
    redirect to('/apartments/:apartment_id/search/results')
  end

  get '/apartments/:apartment_id/search/results' do
    @apartment_id = params['apartment_id'].to_i
    @apartments = settings.apartments.return_apartments
    @apartment = settings.apartments[@apartment_id]
    sorted_apartments = CalculatingModule.search(@apartments, @apartment)
    @sorted_apartments = sorted_apartments.return_apartments
    erb :results
  end

  post '/sort_by_district' do
    @page_count = settings.apartments.page_count
    settings.apartments.sort_by_district
    @apartments_with_index = settings.apartments.apartments
    redirect to('/apartments')
  end

  post '/sort_by_rooms' do
    @page_count = settings.apartments.page_count
    settings.apartments.sort_by_rooms
    @apartments_with_index = settings.apartments.apartments
    redirect to('/apartments')
  end

  get '/sort_by_price' do
    @page_count = settings.apartments.page_count
    settings.apartments.sort_by_rooms
    @apartments_with_index = settings.apartments.apartments
    @sorted_apartments = settings.apartments.return_apartments
    erb :sort_by_price
  end

  post '/sorted_by_price' do
    @from = params['from'].to_i
    @to = params['to'].to_i
    @sorted = Apartments.new(settings.apartments.sort_by_price(@from, @to))
    @apartments_with_index = @sorted
    @page_count = @apartments_with_index.page_count
    erb :show_sorted_apartments
  end

  get '/save_apartment' do
    erb :save
  end

  get '/about' do
    erb :about
  end

  run! if app_file == $PROGRAM_NAME
end
