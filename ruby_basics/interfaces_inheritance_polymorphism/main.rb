require_relative './train.rb' 
require_relative './passenger_train.rb' 
require_relative './cargo_train.rb'
require_relative './passenger_carriage.rb'
require_relative './cargo_carriage.rb'
require_relative './station.rb'
require_relative './route.rb'

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
      when 7 then remove_carriage
      when 8 then move_train
      when 9 then list_stations_and_trains_on_it
      end
    end
  end

  private

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
 
  def create_station
    output_with_title(create_station_msg, :new_station)
    name = gets.chomp
    @all_stations << Station.new(name)
  end

  def create_train
    output_with_title(create_train_msg, :new_train)
    selected_train_type = gets.to_i
    train_id = gets.to_i
    selected_train = case selected_train_type
                     when 1 then PassengerTrain
                     when 2 then CargoTrain
                     end
    @all_trains << selected_train.new(train_id)
  end

  def create_route
    output_with_title(list_stations_in(@all_stations), :stations)
    output new_route_msg
    start_station_number = gets.to_i
    end_station_number = gets.to_i
    @all_routes << Route.new(@all_stations[start_station_number - 1], @all_stations[end_station_number - 1])
  end    

  def modify_route
    output_with_title(list_routes, :routes)
    output modify_route_msg
    selected_route_number = gets.to_i
    selected_route = @all_routes[selected_route_number - 1]
    selected_modify_action = gets.to_i
    case selected_modify_action
    when 1 # for add
      output_with_title(list_stations_in(@all_stations), :stations)
      output add_station_msg
      selected_station_number = gets.to_i
      selected_route.add_station(@all_stations[selected_station_number - 1])
    when 2 # for remove
      output_with_title(list_stations_in(selected_route.stations), :stations)
      output remove_station_msg
      selected_station_number = gets.to_i
      selected_station = selected_route.stations[selected_station_number - 1]
      selected_route.delete_station(selected_station)
    end
  end

  def set_route
    output_with_title(list_routes, :routes)
    output type_number_msg
    selected_route_number = gets.to_i
    output_with_title(list_trains_in(@all_trains), :trains)
    output type_number_msg
    selected_train_number = gets.to_i
    selected_train = @all_trains[selected_train_number - 1]
    selected_route = @all_routes[selected_route_number - 1]
    selected_train.set_route(selected_route)
  end
  
  def add_carriage
    output_with_title(list_trains_in(@all_trains), :trains)
    output type_number_msg
    selected_train_number = gets.to_i
    selected_train = @all_trains[selected_train_number - 1]
    selected_carriage = case selected_train.type
                        when :passenger then PassengerCarriage
                        when :cargo then CargoCarriage
                        end
    selected_train.add_carriage(selected_carriage.new)
  end
  
  def remove_carriage
    output_with_title(list_trains_in(@all_trains), :trains)
    output type_number_msg
    selected_train_number = gets.to_i
    selected_train = @all_trains[selected_train_number - 1]
    selected_train.remove_carriage
  end
  
  def move_train
    output_with_title(list_trains_in(@all_trains), :trains)
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
    output_with_title(list_stations_in(@all_stations), :stations) 
    output type_number_msg
    selected_station_number = gets.to_i
    selected_station = @all_stations[selected_station_number - 1]
    output_with_title(list_trains_in(selected_station.trains), :trains)
    sleep 3
  end
  
  #####
  # Output & message methods
  #####

  def output_with_title(content, title_name)
    print "-" * 45
    puts "\n\t #{title[title_name]} \n"
    output(content)
  end

  def output(content)
    content.each { |text| puts text } unless content.empty?
  end 

  def main_menu
    [ '0 - Exit the program',
      '1 - Create station',
      '2 - Create train',
      '3 - Create  route',
      '4 - Modify route',
      '5 - Set route to the train',
      '6 - Add carriage to the train',
      '7 - Remove carriage from the train',
      '8 - Move train between stations',
      '9 - Display stations list and trains on them.',
      'Type number for action...']
  end
  
  def title
    {
             main: 'Main menu',
      new_station: 'New station menu',
        new_train: 'New train menu',
         stations: 'Stations list',
           routes: 'Routes list',
           trains: 'Trains list'
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

  def move_train_msg
    ["Type '1' to move forward",
     "Type '2' to move backward"]
  end
end

railway = Main.new
railway.run
