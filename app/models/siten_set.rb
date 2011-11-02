class SitenSet < ActiveRecord::Base

  has_many :details, :class_name => 'SitenSetDetail'

end
