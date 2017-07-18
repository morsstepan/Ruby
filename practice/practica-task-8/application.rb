require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/video_catalog'
require_relative 'lib/video'
# A class for an application
class VideoApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/video_catalog.rb'
    also_reload 'lib/video.rb'
  end
  set :catalog, VideoCatalog.new([
                                   Video.new('Trainspotting',
                                             '1995',
                                             'Danny Boyle',
                                             'http://www.imdb.com/title/tt0117951/',
                                             'Renton, deeply immersed in the
                                             Edinburgh drug scene, tries to
                                             clean up and get out,
                                             despite the allure of the drugs and
                                             influence of friends.'),
                                   Video.new('Pulp Fiction',
                                             '1994',
                                             'Quentin Tarantino',
                                             'http://www.imdb.com/title/tt0110912/',
                                             "The lives of two mob hit men,
                                             a boxer, a gangster's wife, and a
                                             pair of diner bandits intertwine
                                             in four tales of violence and
                                             redemption."),
                                   Video.new('Forrest Gump',
                                             '1994',
                                             'Robert Zemeckis',
                                             'http://www.imdb.com/title/tt0109830/',
                                             'While not intelligent,
                                             Forrest Gump has
                                             accidentally been present
                                             at many historic moments,
                                             but his true love,
                                             Jenny Curran, eludes him.'),
                                   Video.new('Saving Private Ryan',
                                             '1998',
                                             'Steven Spielberg',
                                             'http://www.imdb.com/title/tt0120815/',
                                             'Following the Normandy Landings,
                                             a group of U.S. soldiers go behind
                                             enemy lines to retrieve a
                                             paratrooper
                                             whose brothers have been killed
                                             in action.'),
                                   Video.new('Andrey Rublev',
                                             '1966',
                                             'Федя Бонд',
                                             'http://www.imdb.com/title/tt0060107/',
                                             'The life, times and afflictions
                                             of the fifteenth-century Russian
                                             iconographer.'),
                                   Video.new('Black Mirror',
                                             '2011',
                                             'Charlie Brooker',
                                             'http://www.imdb.com/title/tt2085059/',
                                             'A television anthology series that
                                             shows the dark side of life and
                                             technology.'),
                                   Video.new('Zerkalo',
                                             '1975',
                                             'Andrei Tarkovsky',
                                             'http://www.imdb.com/title/tt0072443/',
                                             'A dying man in his forties
                                             remembers his past.
                                             His childhood, his mother,
                                             the war, personal moments and
                                             things
                                             that tell of the recent history of
                                             all the Russian nation.'),
                                   Video.new('Frozen',
                                             '2013',
                                             'fd',
                                             'http://www.imdb.com/title/tt2294629/',
                                             'When the newly crowned Queen Elsa
                                             accidentally uses her power to
                                             turn things into ice to curse
                                             her home in infinite winter,
                                             her sister, Anna, teams up with
                                             a mountain man, his playful
                                             reindeer, and a snowman to
                                             change the weather condition.'),
                                   Video.new('Amadeus',
                                             '1984',
                                             'Milos Forman',
                                             'http://www.imdb.com/title/tt0086879/',
                                             'The incredible story of Wolfgang
                                             Amadeus Mozart, told by his
                                             peer and secret rival Antonio
                                             Salieri - now confined to an
                                             insane asylum.'),
                                   Video.new('Taxi Driver',
                                             '1976',
                                             'Martin Scorsese',
                                             'http://www.imdb.com/title/tt0075314/',
                                             'A mentally unstable Vietnam War
                                             veteran works as a night-time
                                             taxi driver in New York City
                                             where the perceived decadence
                                             and sleaze feeds his urge for
                                             violent action, attempting to
                                             save a preadolescent prostitute
                                             in the process.'),
                                   Video.new('The Lord of the Rings',
                                             '2001',
                                             'Peter Jackson',
                                             'http://www.imdb.com/title/tt0120737/',
                                             'A meek Hobbit from the Shire
                                             and eight companions set out
                                             on a journey to destroy the
                                             powerful One Ring and save
                                             Middle Earth from the
                                             Dark Lord Sauron.'),
                                   Video.new('The Young Pope',
                                             '2016',
                                             'Paolo Sorrentino',
                                             'http://www.imdb.com/title/tt3655448/',
                                             'The beginning of the pontificate
                                             of
                                             Lenny Belardo,
                                             alias Pius XIII,
                                             the first American Pope in
                                             history.'),
                                   Video.new('Sherlock',
                                             '2010',
                                             'Steven Moffat',
                                             'http://www.imdb.com/title/tt1475582/',
                                             'A modern update finds the famous
                                             sleuth and his doctor partner
                                             solving crime in 21st century
                                             London.'),
                                   Video.new('Hugo',
                                             '2011',
                                             'Martin Scorsese',
                                             'http://www.imdb.com/title/tt0970179/',
                                             'In Paris in 1931, an orphan named
                                             Hugo Cabret who lives in the walls
                                             of a train station is wrapped up
                                             in a mystery involving his late
                                             father and an automaton.'),
                                   Video.new('Memento',
                                             '2000',
                                             'Christopher Nolan',
                                             'http://www.imdb.com/title/tt0209144/',
                                             "A man juggles searching for his
                                             wife's murderer and keeping
                                             his short-term memory loss
                                             from being an obstacle."),
                                   Video.new('Inglourious Basterds',
                                             '2009',
                                             'Quentin Tarantino',
                                             'http://www.imdb.com/title/tt0361748/',
                                             "In Nazi-occupied France during
                                             World War II, a plan to
                                             assassinate Nazi leaders by
                                             a group of Jewish U.S. soldiers
                                             coincides with a theatre owner's
                                             vengeful plans for the same.")
                                 ])

  get '/' do
    @amount = settings.catalog.current_amount
    erb :index
  end

  get '/videos' do
    page = if params['page']
             params['page'].to_i
           else
             0
           end
    @videos = settings.catalog.videos(page)
    @page_count = settings.catalog.page_count
    erb :videos
  end

  def change_video(video)
    video.name = params['name']
    video.release_date = params['release_date']
    video.director_name = params['director_name']
    video.link = params['link']
    video.annotation = params['annotation']
  end

  get '/videos/:video_id/delete' do
    video_id = params['video_id'].to_i
    settings.catalog.delete(video_id)
    redirect to('/videos')
  end

  get '/videos/new' do
    erb :new
  end

  post '/videos/:video_id/edit' do
    video_id = params['video_id'].to_i
    @video = settings.catalog[video_id]
    change_video(@video)
    redirect to('/videos')
  end

  get '/videos/:video_id/edit' do
    video_id = params['video_id'].to_i
    @video = settings.catalog[video_id]
    erb :editor
  end

  post '/videos' do
    video = Video.new(params['name'],
                      params['release_date'].to_i,
                      params['director_name'],
                      params['link'],
                      params['annotation'])
    video_id = params['video_id'].to_i
    @video = settings.catalog[video_id]
    settings.catalog << video
    redirect to('/videos')
  end

  get '/about' do
    erb :about
  end

  get '/videos/:video_id' do
    video_id = params['video_id'].to_i
    @video = settings.catalog[video_id]
    erb :video
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
