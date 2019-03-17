module JapanPostalCode
  class PostalArea
    ATTRS = %w{jis_area_code old_code code prefecture_kana city_kana area_kana prefecture city area}.freeze
    FLAGS = %w{has_multiple_code has_koaza has_block_number has_multiple_block}.freeze
    UPDATE_METADATA = %w{update_flag update_reason}.freeze

    (ATTRS + FLAGS + UPDATE_METADATA).each do |attr|
      attr_reader attr.to_sym
    end
    FLAGS.each do |flag|
      define_method(flag + "?") do 
        return send(flag)
      end
    end

    AREA_TO_REMOVE = ["以下に掲載がない場合", "（地階・階層不明）", "（次のビルを除く）"].freeze
    AREA_KANA_TO_REMOVE = ["ｲｶﾆｹｲｻｲｶﾞﾅｲﾊﾞｱｲ", "(ﾁｶｲ･ｶｲｿｳﾌﾒｲ)", "(ﾂｷﾞﾉﾋﾞﾙｦﾉｿﾞｸ)"].freeze
    AREA_GSUB_REGEX = Regexp.new(AREA_TO_REMOVE.join("|"))
    AREA_KANA_GSUB_REGEX = Regexp.new(AREA_KANA_TO_REMOVE.join("|"))

    attr_reader :area_without_meta, :area_kana_without_meta

    def initialize(record)
      if record.is_a? Array
        record.first(9).zip(ATTRS).each do |col, attr|
          instance_variable_set("@" + attr, col)
        end
        record.slice(9, 4).zip(FLAGS).each do |col, attr|
          instance_variable_set("@" + attr, (col == "1"))
        end
      elsif attributes.is_a? Hash
        # for database source
      end
      set_attr_without_meta
    end

    def to_s
      "〒#{@code}: #{address}"
    end

    def address
      "#{@prefecture}#{@city}#{@area_without_meta}"
    end

    def mergeable_with?(other)
      @code == other.code && @prefecture == other.prefecture && @city == other.city && @area_kana == other.area_kana
    end

    def set_attr_without_meta
      if has_multiple_code?
        remove_parenthesis = /（.*）/
        @area_without_meta = @area.gsub(remove_parenthesis, "")
        @area_kana_without_meta = @area_kana.gsub(remove_parenthesis, "")
      else
        @area_without_meta = @area.gsub(AREA_GSUB_REGEX, "")
        @area_kana_without_meta = @area_kana.gsub(AREA_KANA_GSUB_REGEX, "")
      end
    end

    def merge(other)
      @area += other.area
      set_attr_without_meta
    end
  end
end
