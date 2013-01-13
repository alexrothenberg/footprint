class CreateLeopards < ActiveRecord::Migration
  def self.up
    create_table :leopards, :force => true do |t|
      t.string      :name
      t.string      :region
      t.integer     :height
      t.integer     :weight
      t.integer     :strength
      t.integer     :speed
      t.integer     :aggression
      t.string      :notes
      t.timestamps
    end
  end
  
  def self.down
    drop_table  :leopards
  end
end