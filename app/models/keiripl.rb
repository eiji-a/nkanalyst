class Keiripl < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(serial, siten)
    Plbase.load(Keiripl, serial, siten)
  end

  # INSTANCE METHODS

end
