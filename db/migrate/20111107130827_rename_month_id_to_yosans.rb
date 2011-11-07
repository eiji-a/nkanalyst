class RenameMonthIdToYosans < ActiveRecord::Migration
  def self.up
    rename_column :yosans, :month_id, :month
  end

  def self.down
    rename_column :yosans, :month, :month_id
  end
end
