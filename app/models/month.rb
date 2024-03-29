class Month < ActiveRecord::Base

  validates_numericality_of :month
  validates_uniqueness_of :month

  # CONSTANTS
  FIXED   = true
  UNFIXED = false

  # CLASS METHODS

  def Month.month2serial(month)
    y, m = split_month(month)
    if m <= 6
      y -= 1
    end
    ym2serial(y, to_month(m))
  end

  def Month.serial2month(serial)
    y, m = split_month(serial)
    if m >= 7
      y += 1
    end
    ym2serial(y, to_month(m))
  end

  def Month.yyyy_mm(serial)
    y, m = split_month(serial)
    if m >= 7
      y += 1
    end
    return y, to_month(m)
  end

  def Month.year(serial)
    serial / 100
  end

  def Month.prev(serial)
    y, m = split_month(serial)
    if m == 1
      ym2serial(y - 1, 12)
    else
      serial - 1
    end
  end

  def Month.next(serial)
    y, m = split_month(serial)
    if m == 12
      ym2serial(y + 1, 1)
    else
      serial + 1
    end
  end

  def Month.prev_year(serial)
    y, m = split_month(serial)
    ym2serial(y - 1, m)
  end

  def Month.last_year(serial)
    prev_year(serial)
  end

  def Month.next_year(serial)
    y, m = split_month(serial)
    ym2serial(y + 1, m)
  end

  def Month.valid?(serial)
    begin
      split_month(serial)
    rescue
      false
    end
    true
  end

  def Month.first_month(serial)
    y, m = split_month(serial)
    to_serial(y, 1)
  end

  def Month.last_month(serial)
    y, m = split_month(serial)
    to_serial(y, 12)
  end

  def Month.to_serial(year, month)
    year * 100 + month
  end

  def Month.ym2serial(year, month)
    year * 100 + month
  end

  def Month.to_month(month)
    (month + 5) % 12 + 1
  end

=begin
  def Month.to_serial(month)
    (month - 5) % 12 + 1
  end
=end

  def Month.split_month(serial)
    raise ArgumentError, "invalid type: #{serial}" if serial.class != Fixnum
    m = serial % 100
    raise ArgumentError, "invalid month: #{serial}" if m < 1 || 12 < m
    y = serial / 100
    raise ArgumentError, "invalid year: #{serial}" if y < 1900 || 2100 < y
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
