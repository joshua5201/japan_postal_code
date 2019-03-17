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

        if @data.has_key?(area.code)
          record = @data[area.code]
          if record.is_a?(PostalArea)
            if record.mergeable_with?(area)
              record.merge(area)
              next
            else
              @data[area.code] = [record]
            end
          end

          merged = false
          same_code_areas = @data[area.code]
          same_code_areas.each do |same_code_area|
            if same_code_area.mergeable_with?(area)
              same_code_area.merge(area)
              merged = true
              break
            end
          end
          unless merged
            same_code_areas << area
          end
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
