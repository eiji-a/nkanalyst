# -*- coding: utf-8 -*-
class Zisseki < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(serial, siten)
    Plbase.load(Zisseki, serial, siten)
  end

  def self.load_cumulative(serial, siten)
    Plbase.load_cumulative(Zisseki, serial, siten)
  end

  def self.load_total(serial, siten)
    sels = []
    INPUTS.each do |i|
      sels << "SUM(#{i[1]}) AS #{i[1]}"
    end
    sql = <<-SQL
      SELECT siten_id,
             #{ITEM_SUMS}
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

  def self.load_12months(year, siten)
    Plbase.load_12months(Zisseki, year, siten)
  end

  def self.load_yearly(year, siten)
    Plbase.load_yearly(Zisseki, year, siten)
  end

  def self.load_halves(year, siten)

  end

  # INSTANCE METHODS

end
