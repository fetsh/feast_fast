module FeastFast
  class Day

    attr_reader :feasts, :fast

    # TODO: передавать не дату, а параметры, из которых может быть инциализирована дата
    def initialize(day=Date.today)
      @day = day
      @feasts = DB.hash(@day.year)[@day][:feast]
      @fast = DB.hash(@day.year)[@day][:fast]
    end

    def easter?
      @day == DB.easter(@day.year)
    end

  end
end