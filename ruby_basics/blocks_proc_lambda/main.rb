require_relative './station.rb'
require_relative './route.rb'
require_relative './train.rb' 
require_relative './passenger_train.rb' 
require_relative './cargo_train.rb'
require_relative './carriage.rb'
require_relative './passenger_carriage.rb'
require_relative './cargo_carriage.rb'

class Main
  def initialize
    @all_stations = []
    @all_trains = []
    @all_routes = []
  end

  def run
    loop do
      output_with_title(main_menu, :main)
      choice = gets.chomp.to_i

      break if choice.zero?

      case choice
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then modify_route
      when 5 then set_route
      when 6 then add_carriage
      when 7 then occupy_car_capacity
      when 8 then remove_carriage
      when 9 then move_train
      when 10 then list_train_cars_in(@all_trains)
      when 11 then list_stations_and_trains_on_it
      when 12 then load_test_data
      when 13 then list_all_railway
      end
    end
  end

  private

  def load_test_data
    stations_names = ['berlin', 'rome', 'zurich', 'paris']
    # params for train: first number - 1 for passenger, 2 for cargo, then train id
    trains_params = [[1, '123-23'], [2, '321-32'], [1, '432-44']]
    routes_params = [[1, 2], [2, 3], [3, 4]]
    capacity = { cargo: 15000, passenger: 84 }

    stations_names.each { |station_name| create_station {station_name} } 
    routes_params.each { |route_params| create_route {route_params} }
    trains_params.each.with_index(1) do |train_params, index| 
      create_train {train_params}
      carriage_count = rand(3..7)
      carriage_count.times do |times_index|
         if train_params.first == 1
           capacity_number = capacity[:passenger]
         else 
           capacity_number = capacity[:cargo]
         end
        add_carriage { [index, capacity_number] }
      end
    end
    routes_params.count.times.with_index(1) { |index| set_route {index} }
  end 

  def list_stations_in(set)
    set.map.with_index(1) do |station, number| 
      "#{number} - #{station.name}" 
    end
  end  

  def list_routes
    @all_routes.map.with_index(1) do |route, number| 
      "#{number} - "\
        "#{list_stations_in(route.stations)}"
    end
  end

  def list_trains_in(set)
    set.map.with_index(1) do |train, number|
      "#{number} - id: #{train.train_id} -"\
      " type: #{train.type} - carriages: #{train.carriages.count}"
    end
  end  

  def list_train_cars_in(collection)
    collection.map.with_index(1) do |train, number| 
      output_title('') { "Train with cars" }
      puts "#{number} - id: #{train.train_id} - "\
               "#{train.type.to_s} - cars: #{train.carriages.count}"
      car = train.every_car_at_the_train {train} 
      car.map.with_index(1) do |car, number|
        puts "  car № #{number} - #{car.type} - capacity: #{car.capacity} "\
               "- occupied: #{car.occupied_capacity} - free: #{car.free_capacity}"
      end
    end  
  end

  def list_all_railway
    @all_stations.map do |station| 
      trains = station.every_train_at_the_station {station} 
      output_title('') {station.name}
      list_train_cars_in(trains)
    end
  end

  def create_station
    if block_given? 
      name = yield 
    else
      output_with_title create_station_msg, :new_station
      name = gets.chomp
    end
    @all_stations << Station.new(name)
  rescue RuntimeError => e
    output_with_title e.message, :error
    retry
  else
    output_with_title "#{name.capitalize} "\
                      "station was created", :created
  end

  def create_train
    if block_given?
      selected_train_type = yield[0]
      train_id = yield[1]
    else
      output_with_title create_train_msg, :new_train
      selected_train_type = gets.to_i
      train_id = gets.chomp
    end
    selected_train = case selected_train_type
                     when 1 then PassengerTrain
                     when 2 then CargoTrain
                     end
    @all_trains << selected_train.new(train_id)
  rescue RuntimeError => e
    output_with_title e.message, :error
    retry
  else
    output_with_title "№ #{train_id} - #{@all_trains.last.type} "\
           "train was created", :created
  end

  def create_route
    if block_given?
      start_station_number = yield.first
      end_station_number = yield.last
    else
      output_with_title list_stations_in(@all_stations), :stations
      output new_route_msg
      start_station_number = gets.to_i
      end_station_number = gets.to_i
    end
    new_route = Route.new(@all_stations[start_station_number - 1], @all_stations[end_station_number - 1])
    @all_routes << new_route
  rescue RuntemeError => e
    output_with_title e.message, :error
    retry
  else
    output_with_title "Route from #{new_route.stations.first.name.capitalize} to "\
                      "#{new_route.stations.last.name.capitalize} was created", :created
  end    

  def modify_route
    output_with_title list_routes, :routes
    output modify_route_msg
    selected_route_number = gets.to_i
    selected_route = @all_routes[selected_route_number - 1]
    selected_modify_action = gets.to_i
    case selected_modify_action
    when 1 # for add
      output_with_title list_stations_in(@all_stations), :stations
      output add_station_msg
      selected_station_number = gets.to_i
      selected_route.add_station @all_stations[selected_station_number - 1] 
    when 2 # for remove
      output_with_title list_stations_in(selected_route.stations), :stations
      output remove_station_msg
      selected_station_number = gets.to_i
      selected_station = selected_route.stations[selected_station_number - 1]
      selected_route.delete_station(selected_station)
    end
  end

  def set_route
    if block_given?
      selected_route_number = yield
      selected_train_number = yield
    else
      output_with_title list_routes, :routes
      output type_number_msg    
      selected_route_number = gets.to_i
      output_with_title list_trains_in(@all_trains), :trains
      output type_number_msg
      selected_train_number = gets.to_i
    end
    selected_train = @all_trains[selected_train_number - 1]
    selected_route = @all_routes[selected_route_number - 1]
    selected_train.set_route(selected_route)
  end
  
  def add_carriage
    if block_given?
      selected_train_number = yield.first
      capacity_number = yield.last
    else
      output_with_title list_trains_in(@all_trains), :trains
      output add_carriage_msg
      selected_train_number = gets.to_i
      capacity_number = gets.to_i
    end
    selected_train = @all_trains[selected_train_number - 1]
    selected_carriage = case selected_train.type
                        when :passenger then PassengerCarriage
                        when :cargo then CargoCarriage
                        end
    selected_train.add_carriage(selected_carriage.new(capacity_number))
  rescue RuntimeError => e
    output_with_title e.message, :error
    retry
  else
    output 'Carriage was added'
  end

  def occupy_car_capacity
    output_with_title list_trains_in(@all_trains), :trains
    output "Select train number"
    train_number = gets.to_i
    train = @all_trains[train_number - 1]
    list_train_cars_in [train]
    output ["Select carriage number to occupy",
           "then type capacity number"]
    carriage_number = gets.to_i
    capacity_value = gets.to_i
    if train.type == :cargo
      train.carriages[carriage_number - 1].occupy_capacity(capacity_value) 
    else
      train.carriages[carriage_number - 1].occupy_capacity
    end
  rescue RuntimeError => e
    output_with_title e.message, :error
    retry
  else
    output_title ('') { 'carriage capacity was changed' }
    list_train_cars_in [train]
  end
  
  def remove_carriage
    output_with_title list_trains_in(@all_trains), :trains
    output type_number_msg
    selected_train_number = gets.to_i
    selected_train = @all_trains[selected_train_number - 1]
    selected_train.remove_carriage
  end
  
  def move_train
    output_with_title list_trains_in(@all_trains), :trains
    output type_number_msg
    selected_train_number = gets.to_i
    selected_train = @all_trains[selected_train_number - 1]    
    output move_train_msg
    case gets.to_i
    when 1 then selected_train.move_forward
    when 2 then selected_train.move_backward
    end
  end
  
  def list_stations_and_trains_on_it
    output_with_title list_stations_in(@all_stations), :stations
    output type_number_msg
    selected_station_number = gets.to_i
    selected_station = @all_stations[selected_station_number - 1]
    output_with_title list_trains_in(selected_station.trains), :trains 
  end
  
  #####
  # Output methods
  #####

  def output(content)
    unless content.empty?
      if content.is_a? String
        puts content
      else
        content.each { |text| puts text }
      end
    end
  end 

  def output_title(title_name)
    print "-" * 45
    if block_given?
      puts "\n\t #{yield.capitalize} \n"
    else
      puts "\n\t #{title[title_name]} \n"
    end
  end

  def output_with_title(content, title_name)
    output_title(title_name)
    output(content)
  end

  def main_menu
    [ '0 - Exit the program',
      '1 - Create station',
      '2 - Create train',
      '3 - Create  route',
      '4 - Modify route',
      '5 - Set route to the train',
      '6 - Add carriage to the train',
      '7 - Occupy carriage capacity',
      '8 - Remove carriage from the train',
      '9 - Move train between stations',
      '10 - List train cars info',
      '11 - Display stations list and trains on them.',
      '12 - Load test data',
      '13 - List ALL RAILWAY',
      'Type number for action...']
  end

  #####
  # Title & messages
  #####
  
  def title
    {
             main: 'Main menu',
      new_station: 'New station menu',
        new_train: 'New train menu',
         stations: 'Stations list',
           routes: 'Routes list',
           trains: 'Trains list',
            error: 'ERROR!',
          created: 'Object was created'
    }
  end

  def create_station_msg
    ['Enter station name...']
  end

  def create_train_msg
    ["Type '1' for passenger or '2' for cargo.",
     'Then Enter train id number.'] 
  end
  
  def new_route_msg
    ['To set start station of new route - ',
     'enter its number from the station list.',
     'Then enter number of end route station.']
  end
  
  def modify_route_msg
    ['To modify enter route number from list above.',
     "Then type '1' to add or '2' to remove station."]
  end
 
  def add_station_msg   
    ['Next enter station number from station list above.']
  end

  def remove_station_msg
    ['Next enter station index from route stations list above.']
  end

  def type_number_msg
    ['Type the number: ']
  end

  def add_carriage_msg
    ['Type number of train to add carriage and',
     'Enter carriage capacity number']
  end

  def move_train_msg
    ["Type '1' to move forward",
     "Type '2' to move backward"]
  end
end

railway = Main.new
railway.run
