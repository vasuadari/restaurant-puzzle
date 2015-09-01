class ValueMeal
	attr_reader :price, :qty

	def initialize(restaurant_id, price, items, qty)
		@restaurant_id = restaurant_id
    @price = price
    @items = items
		@qty = qty.split('x').last.to_i
	end

	def items
		@items ? @items * qty : []
	end

	def item_names
		items.map(&:name)
	end

	def all?(item_names)
		self.item_names.all? { |name| item_names.include?(name) }
	end

	def cost_of_all_items(item_names, price = 0)
		indices = self.item_names.map { |item| item_names.index(item) }
		if !indices.size.zero? && indices.size == self.items.size
	    new_indices = Array(0..item_names.size - 1) - indices
	    new_item_names = new_indices.map { |index| item_names[index] }
	    price += self.price
	    if new_indices.any? && self.all?(new_item_names)
	      cost_of_all_items(new_item_names, price)
	    else
	      [new_item_names, price]
	    end
	  else
      [item_names, price]
	  end
	end
end
