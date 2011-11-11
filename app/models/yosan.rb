class Yosan < ActiveRecord::Base
  include Plbase

  # CONSTANTS

  # CLASS METHODS

  def self.load(serial, siten)
    Plbase.load(Yosan, serial, siten)
  end

  # INSTANCE METHODS

end
