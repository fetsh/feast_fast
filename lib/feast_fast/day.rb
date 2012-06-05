module FeastFast
  require "delegate"
  class Day < DelegateClass(Date)

    attr_reader :feasts, :fast

    def initialize(*params)
      if params.size == 1 && params.last.instance_of?( Date )
        @date = params.last
      else
        @date = Date.new(*params)
      end
      @easter, @hash = DB.send("year_#{@date.year}".to_sym)
      @feasts = @hash[@date][:feasts]
      @fast = @hash[@date][:fast]
      super(@date)
    end

    def self.today
      self.new(Date.today())
    end

    def easter?
      @date == @easter
    end

    def + (n)
      case n
      when Numeric; return self.class.new(@date + n)
      end
      raise TypeError, 'expected numeric'
    end

    def - (x)
      case x
      when Numeric; return self.class.new(@date - x)
      when Date;    return @date.ajd - x.ajd
      when FeastFast::Day; return @date.ajd - x.ajd
      end
      raise TypeError, 'expected numeric or date'
    end

    def <=> (other)
      case other
      when Numeric; return @date.ajd <=> other
      when Date;    return @date.ajd <=> other.ajd
      when FeastFast::Day; return @date.ajd <=> other.ajd
      end
      nil
    end

    def === (other)
      case other
      when Numeric; return @date.jd == other
      when Date;    return @date.jd == other.jd
      when FeastFast::Day; return @date.jd == other.jd
      end
      false
    end


    def next_day(n=1) self + n end
    def prev_day(n=1) self - n end

    def next() next_day end
    def prev() prev_day end

    alias_method :succ, :next

  end
end