module FeastFast
  module DB
    def self.data(year)
      year = year.to_i
      return @data[year] if @data && @data.has_key?( year )

      @data ||= {}
      e, d = Calculator.easter_and_days(year)
      @data[year] = {
        :easter => e,
        :days => d
      }
      @data[year]
    end

    class << self; alias_method :year, :data; end

    def self.date(date)
      raise( TypeError, 'expected date' ) unless date.instance_of? Date
      self.data(date.year)[:days][date]
    end

    def self.easter(year)
      year = year.to_i
      self.data(year)[:easter]
    end

  end
end