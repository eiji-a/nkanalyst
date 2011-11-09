class Keiripl < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(serial, siten)
    pl = Keiripl.find(:first,
                   :conditions => ['month = ? AND siten_id = ?',
                                   serial, siten.id])
    if pl == nil
      pl = Keiripl.new
      pl.init(serial, siten)
    end
    pl
  end

  # INSTANCE METHODS

end
