require_relative "csv_source"
require_relative "postal_area"

module JapanPostalCode
  class AddressFinder
    attr_reader :mode, :config
    def initialize(config = {})
      @config = config
      @mode = config[:mode] || "csv"
      if @mode == "csv"
        encoding = config[:encoding] || "Shift_JIS"
        @source = CsvSource.new(config[:filename], encoding)
      end
    end

    def query(postal_code)
      @source.query(postal_code)
    end

    def inspect
      "#<JapanPostalCode::AddressFinder mode: #{@mode}, config: #{@config}>"
    end
  end
end
