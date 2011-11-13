class Keiripl < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(serial, siten)
    Plbase.load(Keiripl, serial, siten)
  end
 
  def self.load_cumulative(serial, siten)
    Plbase.load_cumulative(Keiripl, serial, siten)
  end

 # INSTANCE METHODS

end
