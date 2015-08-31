require 'csv'
require_relative 'item_record'

class InputFile
  attr_reader :csv_path

  def initialize(csv_file)
    @csv_path = Pathname.new(csv_file.to_s)

    raise "Missing input csv file: #{csv_path}" unless csv_path.exist?
  end

  def each_record
    CSV.foreach(csv_path) do |row|
      next if row.size == 0

      yield ItemRecord.new(row)
    end
  end
end
