class SitenSet < ActiveRecord::Base
  validates_presence_of :name, :startmonth
  validates_uniqueness_of :name
  validates_uniqueness_of :startmonth

  has_many :details, :class_name => 'SitenSetDetail', :order => 'sequence'

  # CLASS METHODS
  def SitenSet.summarized_by(month, siten)
    range = get_range(month, siten)
    sql = <<-SQL
      SELECT si.*
        FROM sitens as si, siten_sets as st, siten_set_details as dt
       where st.id = :set_id
         AND st.id = dt.siten_set_id
         AND dt.siten_id = si.id
         AND dt.sequence >= :start
         AND dt.sequence <= :end
         AND si.summary_flag = :flag
    SQL

    sitens = Siten.find_by_sql([sql, {:set_id => range.id,
                                  :start => range.range_start,
                                  :end   => range.range_end,
                                  :flag  => false}])
  end

  def SitenSet.get_range(serial, siten)
    return nil if siten.summary_flag == Siten::REAL
    sql = <<-SQL
      SELECT st.*,
             dt.range_start, dt.range_end
        FROM siten_sets as st, siten_set_details as dt
       WHERE dt.siten_id = :siten_id
         AND dt.siten_set_id = st.id
         AND st.startmonth <= :serial
       ORDER BY st.startmonth DESC
    SQL
    set = SitenSet.find_by_sql([sql, {:siten_id => siten.id,
                               :serial => serial])
    return nil if set.size == 0
    set[0].range_start = set[0].range_start.to_i
    set[0].range_end   = set[0].range_end.to_i
    set[0]
  end

  # INSTANCE METHODS
  def validate
    begin
      mon = Month.split_month(startmonth)
    rescue
      errors.add(:startmonth, "invalid month: #{startmonth}")
    end
  end

end
