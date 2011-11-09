# -*- coding: utf-8 -*-
class Zisseki < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def Zisseki.load(serial, siten)
    zi = Zisseki.find(:first,
                      :conditions => ['month = ? AND siten_id = ?',
                                      serial, siten.id])
    if zi == nil
      zi = Zisseki.new
      zi.init(serial, siten)
    end
    zi
  end

  def Zisseki.load_total(serial, siten)
    sels = []
    INPUTS.each do |i|
      sels << "SUM(#{i[1]}) AS #{i[1]}"
    end
    sql = <<-SQL
      SELECT siten_id,
             #{sels.join(", ")}
        FROM zissekis
       WHERE month_id IN ()
    SQL
    zi = Zisseki.find_by_sql([sql, {}])
    if zi == nil
      zi = Zisseki.new
      zi.init(serial, siten)
    end
    zi
  end

  def Zisseki.load_12months(year, siten)
    ye = []
    1.upto(12) do |m|
      ye << Zisseki.load(Month.ym2serial(year, m), siten)
    end
    return ye
  end

  def Zisseki.load_yearly(year, siten)
    mstart = Month.ym2serial(year, 1)
    mend   = Month.ym2serial(year, 12)
    sql = <<-SQL
      SELECT siten_id,
             #{ITEM_SUMS}
        FROM zissekis
       WHERE siten_id = ?
         AND (month >= ? AND month <= ?)
       GROUP BY siten_id
    SQL
    val = Zisseki.find_by_sql([sql, siten.id, mstart, mend])[0]
    if val == nil
      val = Zisseki.new
      val.init(year, siten)
    end
    val
  end

  def Zisseki.load_halves(year, siten)

  end

  # INSTANCE METHODS

end
