module FeastFast
  class Year

    attr_reader :year, :hash, :easter

    def initialize(year)
      @year   = year.to_i
      @easter, @hash = DB.send("year_#{@year}".to_sym)
    end

  end
end