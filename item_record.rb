class ItemRecord
  QTY_REGEX = /x+[0-9]/

  def initialize(csv_row)
    @csv_row = csv_row
  end

  def id
    id = @csv_row.first
    validate(:id, id)
    id.to_i
  end

  def price
    price = @csv_row[1]
    validate(:price, price)
    price.to_f
  end

  def items
    items = @csv_row.slice(2, size).clone
    items.delete_if { |item| !item.match(QTY_REGEX).nil? }
    validate(:items, items)
    items.map(&:strip)
  end

  def size
    @csv_row.size
  end

  def qty
    @csv_row.detect { |item| !item.match(QTY_REGEX).nil? } || 'x1'
  end

  private

  def validate(type, value)
    non_items_conditions = proc { |value| !value.nil? && !value.strip.size.zero? }
    valid =
      case type
      when :id
        non_items_conditions.call(value) && value.to_i != 0
      when :items
        value.any? && !value.size.zero?
      when :price
        non_items_conditions.call(value) && value.to_f != 0.0
      else
        non_items_conditions.call(value)
      end
    raise "invalid #{type}" unless valid
  end
end
