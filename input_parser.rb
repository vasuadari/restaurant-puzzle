require 'pathname'
require_relative 'input_file'
require_relative 'town'

class InputParser
  attr_reader :input_file, :new_town

  def initialize(csv_path, item_names)
    @input_file = InputFile.new(csv_path)
    @item_names = item_names
    parse_data if input_file && input_file.csv_path
  end

  def parse_data
    @new_town = Town.new('Jurgensville')
    input_file.each_record do |record|
      restaurant = new_town.find_or_add_restaurant_by_id(record.id)
      restaurant.add_item_or_meal(record.price, record.items, record.qty)
    end
  end

  def find_cheapest_restaurant
    restaurants = new_town.restaurants
    all_item_names = restaurants.flat_map(&:all_items).map(&:name)
    # Return nil if invalid item
    return nil if @item_names.any? { |name| !all_item_names.include?(name) }

    minimum_cost_from_restaurants =
      new_town.restaurants.map do |restaurant|
        [restaurant.id, restaurant.calculate_cheapest_cost(@item_names)]
      end

    restaurant_id_and_cost = minimum_cost_from_restaurants.sort_by { |id, cost| cost }.first
    restaurant_id_and_cost.last.nil? ? nil : restaurant_id_and_cost
  end

  def print_cheapest_restaurant
    if @item_names.size.zero?
      puts 'Please enter item names to find the cheapest restaurant.'
    else
      restaurant_id_and_cost = find_cheapest_restaurant
      return p nil unless restaurant_id_and_cost

      id, cost = restaurant_id_and_cost
      puts("#{id}, #{cost}")
    end
  end
end
