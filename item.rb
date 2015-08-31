class Item
  attr_reader :name, :price

  def initialize(restaurant_id, price, name)
    @restaurant_id = restaurant_id
    @price = price
    @name = name
  end
end
