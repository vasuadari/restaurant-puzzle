require_relative 'item'

class Restaurant
  attr_reader :id, :items

  def initialize(id)
    @id = id
    @items = []
  end

  def add_item(price, item_names)
    @items << Item.new(id, price, item_names)
  end

  def total_cost(item_names, item_type)
    find_items(item_names, item_type).map(&:price).inject(:+)
  end

  def find_items(item_names, item_type)
    item_names.flat_map { |item_name| find_item(item_name, item_type) }
  end

  def find_item(item_name, item_type)
    items.select { |item| item.names == item_name && item.type == item_type }
  end
end
