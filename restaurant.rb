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

  def add_item_or_meal(price, item_names, qty = 'x1')
    if item_names.size == 1
      add_item(price, item_names.first)
    else
      new_items = item_names.map { |name| Item.new(id, nil, name) }
      @value_meals << ValueMeal.new(id, price, new_items, qty)
    end
  end

  def add_item(price, item_name)
    @items << Item.new(id, price, item_name)
    @items.last
  end

  def find_items(item_names)
    item_names.map { |item_name| find_item(item_name) }.compact
  end

  def find_item(item_name)
    items.detect { |item| item.name == item_name }
  end

  def find_meals_by_items(items)
    value_meals.select { |meal| items.all? { |item| meal.items.member?(item) } }
  end

  def find_meals_by_item_names(item_names)
    value_meals.select { |meal| item_names.all? { |name| meal.item_names.member?(name) } }
  end

  def meal_with_max_items
    value_meals.sort_by { |meal| -meal.items.size }.first
  end

  def total_cost(items)
    items.map(&:price).inject(:+)
  end

  def all_items
    items + value_meals.flat_map(&:items)
  end

  def calculate_cheapest_cost(item_names)
    selected_items = find_items(item_names)
    minimum_cost = total_cost(selected_items)

    if value_meals.any?
      if selected_items.size == item_names.size
        if item_names.size <= meal_with_max_items.items.size
          minimum_cost = find_minimum_cost(minimum_cost, total_cost_of_meals(item_names))
        end
        minimum_cost = find_minimum_cost(minimum_cost, total_cost_of_meals_and_items(item_names))
      else
        meals = item_names.flat_map { |name| find_meals_by_item_names([name]) }
        remaining_item_names = item_names - meals.map(&:item_names)
        minimum_cost = meals.map(&:price).inject(:+) + total_cost(find_items(remaining_item_names))
      end
    else
      return nil unless selected_items.size == item_names.size
    end
    minimum_cost
  end

  def find_minimum_cost(minimum_cost, total_costs)
    if total_costs.any?
      minimum_from_total_costs = total_costs.flatten.compact.min
      if minimum_cost
        minimum_cost < minimum_from_total_costs ? minimum_cost : minimum_from_total_costs
      else
        minimum_from_total_costs
      end
    else
      nil
    end
  end

  def total_cost_of_meals(item_names)
    selected_meals = find_meals_by_item_names(item_names)
    selected_meals.map(&:price)
  end

  def total_cost_of_meals_and_items(item_names, price = 0.0)
    value_meals.map do |meal|
      if meal.all?(item_names)
        new_item_names, new_price = meal.cost_of_all_items(item_names)
        if new_item_names.any?
          total_cost_of_meals_and_items(new_item_names, price + new_price)
        else
          price + new_price
        end
      else
        price + total_cost(find_items(item_names))
      end
    end
  end
end
