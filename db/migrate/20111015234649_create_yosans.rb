class CreateYosans < ActiveRecord::Migration
  def self.up
    create_table :yosans do |t|
      t.integer :month_id, :null => false
      t.integer :siten_id, :null => false

      t.integer :uriage, :default => 0
      t.integer :siire, :default => 0
      t.integer :sitenkan, :default => 0
      t.integer :kisyu, :default => 0
      t.integer :kimatu, :default => 0

      t.integer :kyuryo, :default => 0
      t.integer :syoyo, :default => 0
      t.integer :taisyoku, :default => 0
      t.integer :hotei, :default => 0
      t.integer :haken, :default => 0
      t.integer :hukuri, :default => 0
      t.integer :kokoku, :default => 0
      t.integer :sozei, :default => 0
      t.integer :tinsyaku, :default => 0
      t.integer :tesu, :default => 0
      t.integer :yatin, :default => 0
      t.integer :syokyaku, :default => 0
      t.integer :nenryo, :default => 0
      t.integer :tusin, :default => 0
      t.integer :konetu, :default => 0
      t.integer :ryohi, :default => 0
      t.integer :kaigi, :default => 0
      t.integer :untin, :default => 0
      t.integer :syuzen, :default => 0
      t.integer :hoken, :default => 0
      t.integer :kurasiki, :default => 0
      t.integer :hosyu, :default => 0
      t.integer :syomo, :default => 0
      t.integer :zimu, :default => 0
      t.integer :zappi, :default => 0
      t.integer :sonota, :default => 0
      t.integer :buturyu, :default => 0
      t.integer :henkan, :default => 0

      t.integer :zatusyunyu, :default => 0

      t.integer :zatusyunyuzeinuki, :default => 0
      t.integer :uketoririsoku, :default => 0
      t.integer :siharairisoku, :default => 0
      t.integer :zatusonsitu, :default => 0
      t.integer :syohizeimodori, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :yosans
  end
end
