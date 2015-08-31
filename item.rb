class Item
  attr_reader :names, :price

  def initialize(restaurant_id, price, names)
    @restaurant_id = restaurant_id
    @price = price
    @names = names
    @type = @names.size == 1 ? :single : :meal
  end
end
