#
# A basic class for a person
class Person
  attr_accessor :surname, :name, :patronymic, :sex,
                :birth_day, :birth_month, :birth_year, :city
  def initialize(surname, name, patronymic, sex,
                 birth_day, birth_month, birth_year, city)
    @surname = surname
    @name = name
    @patronymic = patronymic
    @sex = sex
    @birth_day = birth_day
    @birth_month = birth_month
    @birth_year = birth_year
    @city = city
  end

  def name_to_s
    'Full name: ' + @surname + ' ' + @name + ' ' + @patronymic + "\n"
  end

  def sex_to_s
    'Sex: ' + @sex + "\n"
  end

  def date_of_birth_to_s
    'Date of birth: ' + @birth_day.to_s + '.' + @birth_month.to_s +
      + '.' + birth_year.to_s + "\n"
  end

  def city_to_s
    'City: ' + @city + "\n"
  end

  def line_to_s
    '---------------' + "\n"
  end

  def return_person
    name_to_s + sex_to_s + date_of_birth_to_s + city_to_s + line_to_s
  end
end
