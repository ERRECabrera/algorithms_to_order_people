require_relative 'txt_file.rb'
require_relative 'modules.rb'

class Algorithm_to_sort

  include Print

  attr_reader :final_list

  def initialize(people_list,name)
    @people_list = people_list
    @name = name
    @final_list = []
  end

private

  def conditional_weight(person_before,person_after)
    attributes_previus_person = person_before[1]
    attributes_next_person = person_after[1]
    attributes_previus_person[:weight] < attributes_next_person[:weight]
  end

  def conditional_height(person_before,person_after)
    attributes_previus_person = person_before[1]
    attributes_next_person = person_after[1]
    attributes_previus_person[:height] < attributes_next_person[:height]
  end

end