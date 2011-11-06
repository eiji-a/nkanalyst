class RenameOrderColumnToSitenSetDetails < ActiveRecord::Migration
  def self.up
    rename_column :siten_set_details, :order, :sequence
  end

  def self.down
    rename_column :siten_set_details, :sequence, :order
  end
end
