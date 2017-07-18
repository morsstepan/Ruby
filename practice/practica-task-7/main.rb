require 'sinatra'
require 'sinatra/reloader' if development?

@@calculations = []

get '/' do
  @today = Time.now
  @weather_today = 'очень по-весеннему'
  erb :index
end

get '/input' do
  erb :input
end

def triangle_exist?(a, b, c)
  return false if a + b <= c || a + c <= b || b + c <= a
end

def check(a, b, c)
  check_triangle(a, b, c)
  check_values(a, b, c)
end

def calculate_semiperimeter(a, b, c)
  (a + b + c) / 2
end

def calculate_area(a, b, c)
  bad_result = 'Введеный треугольник не существует'
  good_result = 'Площадь заданного треугольника: '
  return bad_result if triangle_exist?(a, b, c) == false
  p = calculate_semiperimeter(a, b, c)
  result = Math.sqrt(p * (p - a) * (p - b) * (p - c)).to_f.round(2)
  good_result + result.to_s
end

post '/calculate' do
  area = calculate_area(params['number_a'].to_f,
                        params['number_b'].to_f,
                        params['number_c'].to_f)
  @@calculations.push(
    number_a: params['number_a'],
    number_b: params['number_b'],
    number_c: params['number_c'],
    result: area
  )
  redirect to("/show?result=#{@@calculations.length - 1}")
end

get '/show' do
  p @@calculations
  # p @@calculations[:result]
  @result = @@calculations[params[:result].to_i]
  erb :show
end

get '/results' do
  @results = @@calculations
  erb :all
end

get '/about' do
  erb :about
end
