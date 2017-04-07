require 'pry'

def generate_random_inputs_into_txtfile(number)
  inputs = ""
  file = "inputs.txt"
  height_range = 150..220
  weight_range = 40.0..160.0
  number.times do |value_not_used|
    inputs += "#{rand(height_range)},#{rand(weight_range).round(2)}\n"
  end
  IO.write(file,inputs)
end

def load_datas_from_txtfile(file)
  datas = IO.read(file)
  inputs = datas.split("\n")
end

def create_list_people_to_study(inputs)
  people = []
  inputs.each_with_index do |input,index|
    person_attributes = input.split(",")
    height = person_attributes[0].to_i
    weight = person_attributes[1].to_f
    coefficient_kilo_value = weight/height
    people << { height: height, weight: weight, kg_co: coefficient_kilo_value }
  end
  people
end

def get_media_statistic_metric(people)
  media = calculate_media(people)
  mediana = calculate_mediana(people)
  inter_media_na = (media + mediana) / 2
end

def calculate_media(people)
  people.reduce(0) {|sum,person| sum + person[:kg_co]} / people.size
end

def calculate_mediana(people)
  kg_cos = [] 
  people.each {|person| kg_cos.push(person[:kg_co])}
  kg_cos.sort[((kg_cos.size-1)/2).round]
end

def generate_people_group_to_sort(people,inter_media_na)
  group = []
  people.each_with_index do |person,index|
    group.push("Human_#{index+1}", { 
      height: person[:height],
      weight: person[:weight],
      deviation: calculate_deviation(person[:kg_co],inter_media_na)
      }
    )
  end
  group = Hash[*group.flatten(1)].sort_by {|key,value| value[:deviation]}
end

def calculate_deviation(value,media)
  deviation = value - media
  deviation.abs
end

def sort_array_with_hash_attributes_by_key(array,key)
  array.sort_by do |object|
    values = object[1]
    values[key.to_sym]
  end
end

def statistic_algorithm_to_sort_people(people)
  people_sorted = [people[0]]
  people.each do |person|
    people_sorted << person
    people_sorted = sort_array_with_hash_attributes_by_key(people_sorted,"height")
    people_sorted.each_with_index do |person_sorted,index|
      if index < people_sorted.size-1
        attributes_person = person_sorted[1]
        attributes_next_person = people_sorted[index+1][1]
        if ( attributes_person[:weight] >= attributes_next_person[:weight]) || ( attributes_person[:height] == attributes_next_person[:height])
          if ( attributes_person[:deviation] > attributes_next_person[:deviation] )
            people_sorted.delete_at(index)
          else
            people_sorted.delete_at(index+1)
          end
        end
      end
    end
  end
  people_sorted
end

def take_person_by(attribute,people,final_list)
  other_attribute = attribute == "height"? "weight" : "height"
  people_sorted = sort_array_with_hash_attributes_by_key(people,attribute)
  first_person = people_sorted[0]
  people_with_same_value = people_sorted.select do |person|
    values_person = person[1]
    values_first_person = first_person[1]
    values_person[attribute.to_sym] == values_first_person[attribute.to_sym]
  end
  sub_people_sorted = sort_array_with_hash_attributes_by_key(people_with_same_value,other_attribute)
  if final_list.size < 1
    final_list << sub_people_sorted[0]
  else
    values_person_final_list = final_list[-1][1]
    check_size = final_list.size
    sub_people_sorted.each do |person|
      values_person = person[1]
      if values_person_final_list[other_attribute.to_sym] < values_person[other_attribute.to_sym] && values_person_final_list[attribute.to_sym] != values_person[attribute.to_sym]
        final_list << person
      end
      break if check_size != final_list.size
    end
  end
end

def generate_posible_list(people,attribute)
  final_list = []
  while people.size > 0
      check_size = people.size
      other_attribute = attribute == "height"? "weight" : "height"
      take_person_by(attribute,people,final_list)
      people = people.select {|person| person[1][attribute.to_sym] != final_list[-1][1][attribute.to_sym] && person[1][other_attribute.to_sym] >= final_list[-1][1][other_attribute.to_sym]}
      break if check_size == people.size #esto arregla aquellos casos en los que quedan elementos en people no utilizables
  end
  return final_list
end

def logical_algorithm_to_sort_people(people)
  alternative_a = generate_posible_list(people, 'height')
  alternative_b = generate_posible_list(people, 'weight')
  return alternative_a.size > alternative_b.size ? alternative_a : alternative_b 
end

def genial_idea(people)
  final_list = []
  new_list = people.map do |person|
    posibilities = people.select {|other| other[1][:height] > person[1][:height] && other[1][:weight] > person[1][:weight]}
    person = [
      person[0], { 
        height: person[1][:height],
        weight: person[1][:weight],
        posibility: posibilities.size
      }]
  end
  new_list = new_list.map do |person|
    posibilities = new_list.select {|other| other[1][:height] > person[1][:height] && other[1][:weight] > person[1][:weight]}
    posibilities << person
    posibility = posibilities.reduce(0) {|sum, person| sum + person[1][:posibility] }
    person = [
      person[0], { 
        height: person[1][:height],
        weight: person[1][:weight],
        posibility: posibility
      }]
  end 
  sorted_list = new_list.sort_by {|person| person[1][:posibility]}
  sorted_list = sorted_list.reverse
  final_list = [sorted_list.shift]
  sorted_list.each do |person|
    if final_list[-1][1][:height] < person[1][:height]
      if final_list[-1][1][:weight] < person[1][:weight]
        final_list << person
      end
    end
  end
  final_list  
end

def print_optimal_solution(people_sorted,algorithm)
  puts "\"The 'people list' more optimal has #{people_sorted.size} persons by algorithm #{algorithm}\"."
  puts ""
  people_sorted.each {|person| puts "- #{person[0]} has #{person[1][:height]} cms and #{person[1][:weight]} kgs."}
  puts ""
end

#generate_random_inputs_into_txtfile(1000)
inputs = load_datas_from_txtfile("inputs.txt")
list_people = create_list_people_to_study(inputs)
inter_media_na = get_media_statistic_metric(list_people)
people_group = generate_people_group_to_sort(list_people,inter_media_na)
people_sorted_by_statistic_algorithm = statistic_algorithm_to_sort_people(people_group)
people_sorted_by_logical_algorithm = logical_algorithm_to_sort_people(people_group)
people_sorted_by_genial_idea = genial_idea(people_group)
puts ""
print_optimal_solution(people_sorted_by_statistic_algorithm,'statistic')
print_optimal_solution(people_sorted_by_logical_algorithm,'logical')
print_optimal_solution(people_sorted_by_genial_idea,'genial')