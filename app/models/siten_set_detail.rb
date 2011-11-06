class SitenSetDetail < ActiveRecord::Base
  validates_numericality_of :siten_id, :siten_set_id
  validates_numericality_of :sequence
  #validates_numericality_of :range_start, :range_end
  validates_uniqueness_of :siten_id, :scope => [:siten_set_id]
  validates_uniqueness_of :sequence, :scope => [:siten_set_id]

  belongs_to :siten_set
  belongs_to :siten

end
