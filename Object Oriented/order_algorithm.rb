require_relative 'algorithm_to_sort.rb'


class Order_algorithm < Algorithm_to_sort

  def initialize(people_list)
    super(people_list,'order')
  end

  def sort_people
    alternative_a = generate_possible_list('height')
    alternative_b = generate_possible_list('weight')
    return alternative_a.size > alternative_b.size ? alternative_a : alternative_b 
  end

private

  def conditional_to_reduce_select_people(person,standar,attribute_a,attribute_b)
    conditon_attribute_a = person[1][attribute_a.to_sym] != standar[1][attribute_a.to_sym]
    conditon_attribute_b = person[1][attribute_b.to_sym] >= standar[1][attribute_b.to_sym]
    conditon_attribute_a && conditon_attribute_b
  end

  def conditional_to_select_peoples_group_by(attribute,person,standar)
    person[1][attribute.to_sym] == standar[1][attribute.to_sym]
  end

  def generate_possible_list(attribute)
    while @people_list.size > 0
        check_size = @people_list.size
        other_attribute = attribute == "height"? "weight" : "height"
        take_person_by(attribute,other_attribute)
        standar = @final_list[-1]
        @people_list.select! {|person| conditional_to_reduce_select_people(person,standar,attribute,other_attribute)}
        break if check_size == @people_list.size #esto arregla aquellos casos en los que quedan elementos
    end
    return @final_list
  end

  def take_person_by(attribute,other_attribute)
    @people_list.sort_by! {|person| person[1][attribute.to_sym]}
    first_person = @people_list[0]
    people_with_same_value = @people_list.select {|person| conditional_to_select_peoples_group_by(attribute,person,first_person)}
    people_with_same_value.sort_by! {|person| person[1][other_attribute.to_sym]}
    if @final_list.size < 1
      @final_list << people_with_same_value.shift
    else
      check_size = @final_list.size
      person_stored = @final_list[-1]
      people_with_same_value.each do |person|
        person_new = person
        if conditional_weight(person_stored,person_new) && conditional_height(person_stored,person_new)
          @final_list << person_new
        end
        break if check_size != @final_list.size
      end
    end
  end

end