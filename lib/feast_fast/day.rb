module FeastFast
  require "delegate"
  class Day < DelegateClass(Date)

    attr_reader :feasts, :fast, :date

    def initialize(*params)
      if params.size == 1 && params.last.instance_of?( Date )
        @date = params.last
      else
        @date = Date.new(*params)
      end
      @feasts = DB.date(@date)[:feasts]
      @fast = DB.date(@date)[:fast]
      super(@date)
    end

    def self.today
      self.new(Date.today())
    end

    def self.easter(year=Date.today.year)
      self.new(DB.data(year.to_i)[:easter])
    end

    def self.with_feasts(year, status)
      DB.feasts(year, status).map{|a| self.new(a[0])}
    end


    def easter?
      @date == DB.data(@date.year)[:easter]
    end

    def fast?
      @fast.status != FeastFast::Fast::STATUS::NO
    end

    def feasts?
      @feasts.any?
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

    def > (x)
      case x
      when Numeric; return @date > x
      when Date;    return @date > x
      when FeastFast::Day; return @date > x.date
      end
      raise TypeError, 'expected numeric or date'
    end
    def < (x)
      case x
      when Numeric; return @date < x
      when Date;    return @date < x
      when FeastFast::Day; return @date < x.date
      end
      raise TypeError, 'expected numeric or date'
    end

    def next_day(n=1) self + n end
    def prev_day(n=1) self - n end

    def next() next_day end
    def prev() prev_day end

    alias_method :succ, :next

  end
end