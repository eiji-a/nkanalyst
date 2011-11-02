class SitenSet < ActiveRecord::Base

  has_many :details, :class => 'SitenSetDetail'

end
