module FeastFast
  module DB
    def self.data(year)
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

    def self.feasts(year, *params)
      days = self.data(year)[:days].select do |date, hash|
        if params.any?
          hash[:feasts].map{|feast| params.include? feast.status}.any?
        else
          hash[:feasts].any?
        end
      end
      Hash[days]
    end
  end
end