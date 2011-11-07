class Yosan < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(serial, siten)
    pl = Yosan.find(:first,
                   :conditions => ['month = ? AND siten_id = ?',
                                   serial, siten.id])
    if pl == nil
      pl = Yosan.new
      pl.init(serial, siten)
    end
    pl
  end

  # INSTANCE METHODS

end
