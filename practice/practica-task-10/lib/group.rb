##
# A basic class for group
class Group
  attr_reader :people
  def initialize(people = [])
    @people = people
  end

  def <<(person)
    @people << person
  end

  def current_amount
    @people.size
  end

  def [](index)
    @people[index]
  end

  def delete(index)
    @people.delete_at(index)
  end
end
