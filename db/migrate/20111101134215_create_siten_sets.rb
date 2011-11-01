class CreateSitenSets < ActiveRecord::Migration
  def self.up
    create_table :siten_sets do |t|
      t.string :name, :null => false, :limit => 50
      t.integer :startmonth, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :siten_sets
  end
end
