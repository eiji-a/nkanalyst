class Siten < ActiveRecord::Base

  # RELATIONSHIP
  has_many :siten_set_details
  has_many :zissekis
  has_many :yosans
  has_many :keiripls

  # CONSTANTS
  SUMMARY = true
  REAL = false
end
