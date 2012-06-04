module FeastFast
  class Year
    def initialize(year)
      @year   = year.to_i
      @hash   = DB.hash(@year)
      @easter = DB.easter(@year)
    end
  end
end