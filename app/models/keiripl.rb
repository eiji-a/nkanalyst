class Keiripl < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(month, siten)
    pl = Keiripl.find(:first,
                   :conditions => ['month_id = ? AND siten_id = ?',
                                   month.id, siten.id])
    if pl == nil
      pl = Keiripl.new
      pl.init(month, siten)
    end
    pl
  end

  # INSTANCE METHODS

end
