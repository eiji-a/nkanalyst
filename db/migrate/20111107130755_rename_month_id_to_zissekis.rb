class RenameMonthIdToZissekis < ActiveRecord::Migration
  def self.up
    rename_column :zissekis, :month_id, :month
  end

  def self.down
    rename_column :zissekis, :month, :month_id
  end
end
