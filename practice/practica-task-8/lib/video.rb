# A class for a film
class Video
  attr_accessor :name, :release_date, :director_name, :link, :annotation

  def initialize(name, release_date, director_name, link, annotation)
    @name = name
    @release_date = release_date
    @director_name = director_name
    @link = link
    @annotation = annotation
  end
end
