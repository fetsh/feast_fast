module FeastFast
  class Day

    attr_reader :feasts, :fast

    def initialize(day=Date.today)
      @day = day
      @feasts = DB.hash[@day][:feast]
      @fast = DB.hash[@day][:fast]
    end

    def easter?
      @day == DB.easter(Date.today.year)
    end

  end
end