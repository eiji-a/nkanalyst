class CreateMonths < ActiveRecord::Migration
  def self.up
    create_table :months do |t|
      t.integer :month
      t.integer :serial
      t.integer :year
      t.integer :order
      t.boolean :fix_flag

      t.timestamps
    end
  end

  def self.down
    drop_table :months
  end
end
