require_relative 'algorithm_to_sort.rb'

class Combinations_algorithm < Algorithm_to_sort

  def initialize(people_list)
    super(people_list,'combinations')
    @lists = []
    add_combinations_info_to_list
    @cache_people = @people_list
  end

  def sort_people(index=0)
    @cache_people.sort_by! {|person| person[1][:possibility_co]}
    @cache_people.reverse!
    @final_list = [@cache_people[index]]
    @cache_people.delete_at(index)
    @cache_people.each do |person|
      if conditional_weight(@final_list[-1], person) && conditional_height(@final_list[-1], person)
        @final_list << person
      end
    end
    @final_list
  end

  def generate_all_lists
    range = 0..(@people_list.size-1)
    range.each do |index|
      @cache_people = Array.new(@people_list)
      @lists << self.sort_people(index)
      @final_list = []
    end
    @lists.sort! {|l1,l2| l2.size <=> l1.size}
    @lists
  end

  def return_the_best_sorted_list
    @final_list = @lists[0]
  end

private

  def add_combinations_info_to_list
    add_possibilities_to_combine
    add_possibility_co
  end

  def add_possibilities_to_combine
    @people_list.map! do |person|
      name = person[0]
      attributes = person[1]
      person = [ name, attributes.merge!(
        possibilities: calculate_possibilities_to_combine(person).size
      )]
    end
  end

  def calculate_possibilities_to_combine(person)
    people_selected = @people_list.select do |other|
      conditional_weight(person,other) && conditional_height(person,other)
    end
  end

  def add_possibility_co
    @people_list.map! do |person|
      name = person[0]
      attributes = person[1]
      person = [ name, attributes.merge!(
        possibility_co: calculate_possibility_co(person)
      )]
    end
  end

  def calculate_possibility_co(person)
    possibilities = calculate_possibilities_to_combine(person)
    possibilities << person
    possibility_co = possibilities.reduce(0) {|sum, person| sum + person[1][:possibilities]}
  end

end