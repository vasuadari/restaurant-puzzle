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
end
