# -*- coding: utf-8 -*-
class Zisseki < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def Zisseki.load(month, siten)
    zi = Zisseki.find(:first,
                      :conditions => ['month_id = ? AND siten_id = ?',
                                      month.id, siten.id])
    if zi == nil
      zi = Zisseki.new
      zi.init(month, siten)
    end
    zi
  end

  def Zisseki.load_12months(year, siten)
    mons = Month.load_yearly(year)
    ye = []
    mons.each do |m|
      ye << Zisseki.load(m, siten)
    end
    return ye
  end

  def Zisseki.load_yearly(year, siten)
    mids = Month.load_yearly(year).map {|m| m.id}
    sql = <<-SQL
      SELECT siten_id,
             #{ITEM_SUMS}
        FROM zissekis
       WHERE siten_id = ?
         AND month_id IN (?)
       GROUP BY siten_id
    SQL
    val = Zisseki.find_by_sql([sql, siten.id, mids])[0]
  end

  def Zisseki.load_halves(year, siten)

  end

  # INSTANCE METHODS

end
