module JapanPostalCode
  class PostalArea
    attr_reader :code, :prefecture, :city, :area, :prefecture_kana, :city_kana, :area_kana
    AREA_TO_REMOVE = ["以下に掲載がない場合", "（地階・階層不明）", "（次のビルを除く）"].freeze
    AREA_KANA_TO_REMOVE = ["ｲｶﾆｹｲｻｲｶﾞﾅｲﾊﾞｱｲ", "(ﾁｶｲ･ｶｲｿｳﾌﾒｲ)", "(ﾂｷﾞﾉﾋﾞﾙｦﾉｿﾞｸ)"].freeze
    AREA_GSUB_REGEX = Regexp.new(AREA_TO_REMOVE.join("|"))
    AREA_KANA_GSUB_REGEX = Regexp.new(AREA_KANA_TO_REMOVE.join("|"))

    def initialize(attributes)
      if attributes.is_a? Array
        @code = attributes[2]
        @prefecture = attributes[6]
        @city = attributes[7]
        @prefecture_kana = attributes[3]
        @city_kana = attributes[4]
        @multiple_code = attributes[9] == "1"
        @has_area_number = attributes[11] == "1"
        @multiple_area = attributes[12] == "1"
        @area = attributes[8]
        @area_kana = attributes[5]
      elsif attributes.is_a? Hash
      end
      if multiple_code?
        remove_bracket = /（.*）/
        @area = @area.gsub(remove_bracket, "")
        @area_kana = @area.gsub(remove_bracket, "")
      else
        @area = @area.gsub(AREA_GSUB_REGEX, "")
        @area_kana = @area.gsub(AREA_KANA_GSUB_REGEX, "")
      end
    end

    def multiple_area?
      @multiple_area 
    end

    def multiple_code?
      @multiple_code
    end

    def has_area_number?
      @has_area_number
    end

    def to_s
      "〒#{@code}: #{address}"
    end

    def address
      "#{@prefecture}#{@city}#{@area}"
    end
  end
end
