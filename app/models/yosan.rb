class Yosan < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(serial, siten)
    pl = nil
    if siten.summary_flag == Siten::REAL
      pl = Yosan.find(:first,
                      :conditions => ['month = ? AND siten_id = ?',
                                      serial, siten.id])
    else
      pl = nil
    end

    if pl == nil
      pl = Yosan.new
      pl.init(serial, siten)
    end
    pl
  end

  # INSTANCE METHODS

end
