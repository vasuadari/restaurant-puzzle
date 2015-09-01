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
      restaurant.add_item_or_meal(record.price, record.items, record.qty)
    end
  end

  def print_cheapest_restaurant(item_names)
    restaurants = new_town.restaurants
    all_item_names = restaurants.flat_map(&:all_items).map(&:name)
    # Return nil if invalid item
    return p(nil) if item_names.any? { |name| !all_item_names.include?(name) }

    if item_names.size.zero?
      puts 'Please enter item names to find the cheapest restaurant.'
    else
      minimum_cost_from_restaurants =
        new_town.restaurants.map do |restaurant|
          [restaurant.id, restaurant.calculate_cheapest_cost(item_names)]
        end
      id, cost = minimum_cost_from_restaurants.sort_by { |id, cost| cost }.first
      cost.nil? ? p(nil) : puts("#{id}, #{cost}")
    end
  end
end
