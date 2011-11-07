class RenameMonthIdToKeiripls < ActiveRecord::Migration
  def self.up
    rename_column :keiripls, :month_id, :month
  end

  def self.down
    rename_column :keiripls, :month, :month_id
  end
end
