class File_txt

  def initialize(file)
    @file = file
  end

  def generate_random_inputs(number)
    inputs = ""
    file = "inputs.txt"
    height_range = 150..220
    weight_range = 40.0..160.0
    number.times do |value_not_used|
      inputs += "#{rand(height_range)},#{rand(weight_range).round(2)}\n"
    end
    IO.write(@file,inputs)
  end

  def return_people_list
    inputs = load_datas
    people = []
    inputs.each_with_index do |input,index|
      person = "Human #{index+1}"
      person_attributes = input.split(",")
      height = person_attributes[0].to_i
      weight = person_attributes[1].to_f
      people << [ person, { height: height, weight: weight }]
    end
    people
  end

private

  def load_datas
    datas = IO.read(@file)
    inputs = datas.split("\n")
  end

end