class CreateSitenSetDetails < ActiveRecord::Migration
  def self.up
    create_table :siten_set_details do |t|
      t.integer :siten_id, :null => false
      t.integer :siten_set_id, :null => false
      t.integer :order, :null => false
      t.integer :range_start
      t.integer :range_end

      t.timestamps
    end
  end

  def self.down
    drop_table :siten_set_details
  end
end
