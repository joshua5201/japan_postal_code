# JapanPostalCode

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
finder = JapanPostalCode::AddressFinder(filename: "02AOMORI.CSV")
finder.query("0380211")

 => #<JapanPostalCode::PostalArea:0x000055e9dd0821c8 @code="0380211", @prefecture="青森県", @city="南津軽郡大鰐町", @prefecture_kana="ｱｵﾓﾘｹﾝ", @city_kana="ﾐﾅﾐﾂｶﾞﾙｸﾞﾝｵｵﾜﾆﾏﾁ", @multiple_code=false, @has_area_number=false, @multiple_area=false, @area="大鰐", @area_kana="大鰐">

```

## Plan

1. Save csv to database (MySQL, PostgreSQL...etc)
2. Query with database

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
