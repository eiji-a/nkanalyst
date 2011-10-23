class CreateSitens < ActiveRecord::Migration
  def self.up
    create_table :sitens do |t|
      t.string :name, :null => false, :limit => 50
      t.string :dispname, :null => false, :limit => 50
      t.boolean :summary_flag

      t.timestamps
    end
  end

  def self.down
    drop_table :sitens
  end
end
