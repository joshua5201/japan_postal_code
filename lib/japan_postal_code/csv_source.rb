require_relative "postal_area"
require 'csv'
module JapanPostalCode
  class CsvSource
    def initialize(filename, encoding)
      @data = {}
      @csv = CSV.open(filename, "r", encoding: encoding)
      @encoding = encoding
      @csv.each do |row|
        if @encoding == "UTF-8"
          area = PostalArea.new(row)
        else
          area = PostalArea.new(row.map {|c| c.encode(Encoding::UTF_8)})
        end
        if area.multiple_area?
          if @data[area.code].nil?
            @data[area.code] = []
          end
          @data[area.code] << area
        else
          @data[area.code] = area
        end
      end
    end

    def query(postal_code)
      @data[postal_code]
    end
  end
end
