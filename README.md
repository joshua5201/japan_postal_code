# JapanPostalCode

I am trying to make the common "Postal code to part of address" feature in Japanese website.

So this program will remove meta info like "その他" or "次のビルを除く" ... etc

This is a hobby project and still in development

## Installation

Add this line to your `Gemfile`

``` ruby
gem "japan_postal_code", github: "joshua5201/japan_postal_code"
```

## Usage

Please download csv file from [Japan Post's Website](https://www.post.japanpost.jp/zipcode/dl/kogaki-zip.html)

example: 

```ruby
require 'japan_postal_code'
finder = JapanPostalCode::AddressFinder(filename: "data/02AOMORI.CSV")
 => #<JapanPostalCode::AddressFinder mode: csv, config: {:filename=>"data/02AOMORI.CSV"}>

finder.query("0380211")
 => #<JapanPostalCode::PostalArea:0x00005640b5152ad8 @jis_area_code="02362", @old_code="03802", @code="0380211", @prefecture_kana="ｱｵﾓﾘｹﾝ", @city_kana="ﾐﾅﾐﾂｶﾞﾙｸﾞﾝｵｵﾜﾆﾏﾁ", @area_kana="ｵｵﾜﾆ", @prefecture="青森県", @city="南津軽郡大鰐町", @area="大鰐", @has_multiple_code=false, @has_koaza=true, @has_block_number=false, @has_multiple_block=false>

```

## Plan

1. Export to SQL Insert statements
2. Export diffential csv to SQL (Update data)
3. Export to JSON
4. Export only desired parts (e.g. by prefecture/city/area) 
5. Query with database

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
