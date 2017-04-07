require_relative 'algorithm_to_sort.rb'


class Statistic_algorithm < Algorithm_to_sort

  def initialize(people_list)
    super(people_list,'statistic')
    @media = calculate_media
    @mediana = calculate_mediana
    @inter_media_na = calculate_inter_media_na
    add_statistic_info_to_list
  end

  def sort_people
    @people_list.sort_by! {|person| person[1][:deviation_co]}
    @final_list = [@people_list.shift]
    @people_list.each do |person|
      @final_list << person
      @final_list = @final_list.sort_by! {|person| person[1][:height]}
      @final_list.each_with_index do |previus_person,index|
        if index < @final_list.size-1
          next_person = @final_list[index+1]
          unless conditional_weight(previus_person,next_person) && conditional_height(previus_person,next_person)
            if conditional_deviation_co(previus_person,next_person)
              @final_list.delete_at(index)
            else
              @final_list.delete_at(index+1)
            end
          end
        end
      end
    end
    @final_list
  end  

private

  def conditional_deviation_co(person_before,person_after)
    attributes_previus_person = person_before[1]
    attributes_next_person = person_after[1]
    attributes_previus_person[:deviation_co] > attributes_next_person[:deviation_co]
  end

  def calculate_media
    @people_list.reduce(0) {|sum,person| sum + calculate_kg_co_value(person)} / @people_list.size
  end

  def calculate_mediana
    kg_cos = [] 
    @people_list.each {|person| kg_cos.push(calculate_kg_co_value(person))}
    kg_cos.sort[((kg_cos.size-1)/2).round]
  end

  def calculate_inter_media_na
    @inter_media_na = (@media + @mediana) / 2
  end

  def calculate_kg_co_value(person)
    coefficient_kilo_value = person[1][:weight]/person[1][:height]
  end

  def calculate_deviation_co(person)
    deviation_co = calculate_kg_co_value(person) - @media
    deviation_co.abs
  end

  def add_statistic_info_to_list
    @people_list.map! do |person|
      name = person[0]
      attributes = person[1]
      person = [ name, attributes.merge!(
        kg_co: calculate_kg_co_value(person),
        deviation_co: calculate_deviation_co(person)
      )]
    end
  end

end