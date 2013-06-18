class Date

  def self.easter(year=self.today.year)
    # FeastFast::DB.data(year.to_i)[:easter]
    raise TypeError, 'expected fixnum' unless year.instance_of? Fixnum
    a = (19 * (year % 19) + 15) % 30
    b = (2 * (year % 4) + 4 * (year % 7) + 6 * a + 6) % 7
    c = a + b
    if c > 9
      d = c - 9 # day
      m = 4 # month
    else
      d = 22 + c # day
      m = 3 # month
    end
    self.new(year, m, d) + 13
  end

  def self.with_feasts(year, *statuses)
    FeastFast::DB.feasts(year, *statuses).keys.sort
  end

  def feasts
    @feasts ||= FeastFast::DB.date(self)[:feasts]
  end
  def fast
    @fast ||= FeastFast::DB.date(self)[:fast]
  end  

  def easter?
    self == FeastFast::DB.data(self.year)[:easter]
  end

  def fast?
    self.fast.status != FeastFast::Fast::STATUS::NO
  end

  def feasts?() self.feasts.any? end

  def next_with_feast(*statuses)
    self.class.with_feasts(self.year, *statuses).find{|d| d > self } || self.class.with_feasts(self.year + 1, *statuses).first
  end

  def prev_with_feast(*statuses)
    self.class.with_feasts(self.year, *statuses).reverse.find{|d| d < self } || self.class.with_feasts(self.year - 1, *statuses).last
  end


  def next_date(n=1) self + n end
  def prev_date(n=1) self - n end

  def next_sunday(step=1)
    days_to_sunday = self.wday!=0 ? 7-self.wday : 0
    days_to_sunday = days_to_sunday + 7*(step-1)
    result = self + days_to_sunday
  end

  def prev_sunday(step=1)
    days_to_sunday = self.wday!=0 ? self.wday : 0
    days_to_sunday = days_to_sunday + 7*(step-1)
    result = self - days_to_sunday
  end

  def weeks_ago(step=1)
    self - 7*step
  end
  def weeks_since(step=1)
    self + 7*step
  end
  def week_ago() weeks_ago end
  def week_since() weeks_since end

  def next_easter
    easter = self.class.easter(self.year)
    if easter > self
      easter
    else
      self.class.easter(self.year + 1)
    end
  end

end