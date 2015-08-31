require 'pathname'
require_relative 'input_file'
require_relative 'town'

class InputParser
  attr_reader :input_file, :new_town

  def initialize(csv_path, item_names)
    @input_file = InputFile.new(csv_path)
    parse_data if input_file && input_file.csv_path
    print_cheapest_restaurant(item_names)
  end

  def parse_data
    @new_town = Town.new('Jurgensville')
    input_file.each_record do |record|
      restaurant = new_town.find_or_add_restaurant_by_id(record.id)
      restaurant.add_item_or_meal(record.price, record.items)
    end
  end

  def print_cheapest_restaurant(item_names)
    if item_names.size.zero?
      puts 'Please enter item names to find the cheapest restaurant.'
    else
      minimum_cost_from_restaurants =
        new_town.restaurants.map do |restaurant|
          [restaurant.id, restaurant.items_combinations(item_names).sort.first]
        end
      id, cost = minimum_cost_from_restaurants.sort_by { |id, cost| cost }.first
      if cost.nil?
        p nil
      else
        puts "#{id}, #{cost}"
      end
    end
  end
end
