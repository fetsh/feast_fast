# FeastFast

Feasts and Fasts of Eastern Orthodox Church hardcoded and calculated.

## Installation

Add this line to your application's Gemfile:

    gem 'feast_fast'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feast_fast

## Usage

``` ruby
    day = FeastFast::Day.today
    puts "Feast: #{day.feasts.first}"
    puts "Fast: #{day.fast}"
```
or 

``` ruby
    (FeastFast::Day.new(2012,4,6)..FeastFast::Day.new(2012,4,8)).each do |day|
      puts "#{day}: #{day.fast}"
    end
```
or

``` ruby
    puts "Congrats! It's Easter today!" if FeastFast::Day.today.easter?

    today = Date.today
    days_till_easter = if FeastFast::Day.easter(today.year) > today
      FeastFast::Day.easter(today.year) - today
    else
      FeastFast::Day.easter(today.year + 1) - today
    end

    puts "#{days_till_easter} days till next easter."
    
    if days_till_easter > 50
      today = FeastFast::Day.today
      if today.feasts.any?
        puts "Don't be sad, today you can celebrate #{today.feasts.first}"
      else
        remaining_feasts = FeastFast::Day.with_feasts(today.year, FeastFast::Feast::STATUS::TWELVE).select{ |feast_day| feast_day > today }
        if remaining_feasts.size > 1
          puts "Don't be sad, there are still #{remaining_feasts.size} Great Feasts in this year:"
          remaining_feasts.sort.each { |date| puts "At #{date.strftime('%d %b')}: #{date.feasts.first}" }
        end
      end
      puts "And don't forget to fast today!" if today.fast?
    end
```

## TODO

- I18n
- exceptions handling
- tests

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request