require 'set'
require_relative 'item'
require_relative 'value_meal'

class Restaurant
  attr_reader :id, :items, :value_meals

  def initialize(id)
    @id = id
    @items = []
    @value_meals = []
  end

  def add_item_or_meal(price, item_names)
    if item_names.size == 1
      @items << Item.new(id, price, item_names.first)
    else
      @value_meals << ValueMeal.new(id, price, find_items(item_names))
    end
  end

  def find_items(item_names)
    item_names.flat_map { |item_name| find_item(item_name) }
  end

  def find_item(item_name)
    items.select { |item| item.name == item_name }
  end

  def find_meals(items)
    value_meals.select { |meal| meal.items == items }
  end

  def total_cost(items)
    items.map(&:price).inject(:+)
  end

  def items_combinations(item_names)
    total_costs = []
    selected_items = find_items(item_names)
    total_costs << total_cost(selected_items)
    selected_meals = find_meals(selected_items)
    total_costs << selected_meals.map { |meal| total_cost(meal.items) }
    total_costs << mixed_combinations(item_names)
    total_costs.flatten.compact
  end

  def mixed_combinations(item_names, price = 0.0)
    value_meals.map do |meal|
      if item_names.join('').include?(meal.item_names.join(''))
        new_item_names, new_price = meal.cost(item_names)
        if new_item_names.any?
          mixed_combinations(new_item_names, price + new_price)
        else
          price + new_price
        end
      else
        price + total_cost(find_items(item_names))
      end
    end
  end
end
