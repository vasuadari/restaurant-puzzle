class ValueMeal
	attr_reader :price, :items

	def initialize(restaurant_id, price, items)
		@restaurant_id = restaurant_id
    @price = price
    @items = items
	end

	def items_and_price
		[items, price]
	end

	def item_names
		items.map(&:name)
	end

	def cost(item_names, price = 0)
		indices = self.item_names.map { |item| item_names.index(item) }
		if indices.size == self.items.size
	    new_indices = Array(0..item_names.size - 1) - indices
	    new_item_names = new_indices.map { |index| item_names[index] }
	    price += self.price
	    if new_indices.any? && new_item_names.join('').include?(self.item_names.join(''))
	      cost(new_item_names, price)
	    else
	      [new_item_names, price]
	    end
	  else
      [item_names, price]
	  end
	end
end
