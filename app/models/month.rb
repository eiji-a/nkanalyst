class Month < ActiveRecord::Base

  validates_numericality_of :month
  validates_uniqueness_of :month

  # CONSTANTS
  FIXED   = true
  UNFIXED = false

  # CLASS METHODS

  def Month.month2serial(month)
    y, m = split_month(month)
    y * 12 + (m - 1)
  end

  def Month.serial2month(serial)
    m = serial % 12 + 1
    y = serial / 12
    return y * 100 + m
  end

  def Month.month2order(month)
    y, m = split_month(month)
    if m <= 6 then m + 6 else m - 6 end
  end

  def Month.month2year(month)
    y, m = split_month(month)
    if m <= 6 then y + 1 else y end
  end

  def Month.split_month(month)
    raise ArgumentError, "invalid type: #{month}" if month.class != Fixnum
    m = month % 100
    raise ArgumentError, "invalid month: #{month}" if m < 1 || 12 < m
    y = month / 100
    raise ArgumentError, "invalid year: #{month}" if y < 2000 || 2100 < y
    return y, m
  end

  def Month.load(month)
    #y, m = split_month(month) # if invalid month then Error!
    mon = Month.find_by_month(month)
    if mon == nil
      mon = Month.new(:month => month)
      mon.save
    end
    return mon
  end

  def Month.load_by_serial(serial)
    Month.load(serial2month(serial))
  end

  def Month.load_yearly(year)
    mons = []
    serial = year * 12 + 6
    12.times do |i|
      mons[i] = Month.load_by_serial(serial + i)
    end
    return mons
  end

  # INSTANCE METHODS

  def save
    set_month(self.month)
    super
  end

  def yyyy
    y, m = Month.split_month(self.month)
    return y
  end

  def mm
    y, m = Month.split_month(self.month)
    return m
  end

  def last_year
    Month.load(((yyyy - 1) * 100 + mm))
  end

  :private

  def set_month(month)
    y, m = Month.split_month(month)
    self.month = month
    self.serial = Month.month2serial(month)
    self.order = Month.month2order(month)
    self.year = if self.order <= 6 then y else y - 1 end
    self.fix_flag = UNFIXED
  end

  def validate
    m = month % 100
    y = month / 100

    unless 1 <= m && m <= 12
      errors.add(:month, "invalid month: #{month}")
    end

    unless 1900 <= y && y <= 2100
      errors.add(:month, "invalid year: #{month}")
    end
  end

end
