class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :mobile_number
      t.string :email
      t.string :name
      t.boolean :can_text
      t.string :saved_game

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
