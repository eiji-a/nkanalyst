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

  # INSTANCE METHODS

end
