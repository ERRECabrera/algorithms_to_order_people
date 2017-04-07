module Print

  def print_optimal_solution
    self.sort_people
    puts "\"The 'people list' more optimal has #{@final_list.size} persons by algorithm #{@name}\"."
    puts ""
    @final_list.each {|person| puts "- #{person[0]} has #{person[1][:height]} cms and #{person[1][:weight]} kgs."}
    puts ""
  end

end