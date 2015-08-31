require_relative 'restaurant'

class Town
  attr_reader :restaurants

  def initialize(name)
    @name = name
    @restaurants = []
  end

  def add_restaurant(restaurant)
    @restaurants << restaurant
  end

  def find_or_add_restaurant_by_id(id)
    restaurant = @restaurants.detect { |restaurant| restaurant.id == id }
    unless restaurant
      restaurant = Restaurant.new(id)
      add_restaurant(restaurant)
    end
    restaurant
  end

  def find_cheapest_restaurant(item_names)
    restaurant_with_meal = cheapest_restaurant_with_or_without_meal(item_names, :meal)
    if restaurant_with_meal.nil?
      find_cheapest_restaurant(item_names, :single)
    else
      restaurant_with_meal
    end
  end

  def cheapest_restaurant_with_or_without_meal(item_names, item_type)
    restaurants_with_items =
      @restaurants.select do |restaurant|
        restaurant.find_items(item_names, item_type)
      end
    if item_type == :single
      restaurants_with_items.select! { |restaurant| restaurant.items.map(&:names) == item_names }
    end

    return nil if restaurants_with_items.size.zero?

    total_cost_in_restaurants = total_cost_in_restaurants(restaurants_with_items, item_names, item_type)
    total_cost_in_restaurants.sort_by { |id, cost| cost }.first
  end

  def total_cost_in_restaurants(restaurants, item_names, item_type)
    restaurants.map do |restaurant|
      [restaurant.id, restaurant.total_cost(item_names, item_type)]
    end
  end
end
