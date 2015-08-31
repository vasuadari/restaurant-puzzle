class ItemRecord
  def initialize(csv_row)
    @csv_row = csv_row
  end

  def id
    id = @csv_row.at(0)
    validate(:id, id)
    id.to_i
  end

  def price
    price = @csv_row.at(1)
    validate(:price, price)
    price.to_f
  end

  def items
    items = @csv_row.slice(2, size)
    validate(:items, items)
    items.map(&:strip)
  end

  def size
    @csv_row.size
  end

  private

  def validate(type, value)
    valid =
      if value.is_a?(Array)
        value.any? && !value.size.zero?
      else
        !value.nil? && !value.strip.size.zero?
      end
    raise "#{type} cannot be empty" unless valid
  end
end
