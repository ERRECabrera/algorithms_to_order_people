require_relative 'combinations_algorithm.rb'
require_relative 'order_algorithm.rb'
require_relative 'statistic_algorithm.rb'
require 'pry'


inputs = 1000
my_inputs_file = File_txt.new('inputs.txt')
#my_inputs_file.generate_random_inputs(inputs)
people_list = my_inputs_file.return_people_list

people_a = Array.new(people_list)
people_b = Array.new(people_list)
people_c = Array.new(people_list)

puts ""
statistic_sort = Statistic_algorithm.new(people_a).print_optimal_solution#.sort_people
order_sort = Order_algorithm.new(people_b).print_optimal_solution#.sort_people
combinations_sort = Combinations_algorithm.new(people_c).print_optimal_solution#.sort_people

#binding.pry
