#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib feast_fast]))

day = Date.new(2012, ARGV[0].to_i, ARGV[1].to_i)
today = FeastFast::Day.new(day)

puts "#{ARGV[1]} #{day.strftime('%B')} -- #{today.fast.text}"
if today.feasts.any?
  today.feasts.each do |feast|
    puts feast.text
  end
end





# puts "HASH: "
# Feastfast::DB.hash.sort.each do |day,hash|
#   puts "#{day.to_s}: #{hash[:feast].size} : #{hash[:feast].last.text}"
# end
