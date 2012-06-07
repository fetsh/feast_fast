#!/usr/bin/env ruby
# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib feast_fast]))

if ARGV.any? && ARGV.size == 3
  begin
    d1 = FeastFast::Day.new(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i)
  rescue Exception => e
    puts "Не удалось сформировать дату"
    puts e
    exit 1
  end
else
  d1 = FeastFast::Day.today
end

puts "====================="
puts "Дата:      #{d1}"
puts "Пост:      #{d1.fast}"
if d1.feasts.any?
  d1.feasts.each_with_index do |feast, index|
    if index == 0
      puts "Праздники: #{feast}"
    else 
      puts "           #{feast}"
    end
  end
else
  puts "Праздники: Нет праздников"
end
puts "====================="

puts ""
puts "Congrats! It's Easter today!" if FeastFast::Day.today.easter?

today = Date.today
days_till_easter = if FeastFast::Day.easter(today.year) > today
  FeastFast::Day.easter(today.year) - today
else
  FeastFast::Day.easter(today.year + 1) - today
end
puts "#{days_till_easter} days till next easter."
puts ""
if days_till_easter > 50
  today = FeastFast::Day.today
  if today.feasts.any?
    puts "Don't be sad, today you can celebrate #{today.feasts.first}"
  else
    remaining_feasts = FeastFast::Day.with_feasts(today.year, FeastFast::Feast::STATUS::TWELVE).select{ |feast| feast > today }
    if remaining_feasts.size > 1
      puts "Don't be sad, there are still #{remaining_feasts.size} Great Feasts in this year:"
      remaining_feasts.sort.each { |date| puts "At #{date.strftime('%d %b')}: #{date.feasts.first}" }
    end
  end


  puts "And don't forget to fast today!" unless today.fast.status == FeastFast::Fast::STATUS::NO
end