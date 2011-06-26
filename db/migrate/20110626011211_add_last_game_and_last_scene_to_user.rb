class AddLastGameAndLastSceneToUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :saved_game
    add_column :users, :last_game, :string
    add_column :users, :last_scene, :string
  end

  def self.down
    remove_column :users, :last_scene
    remove_column :users, :last_game
    add_column :user, :last_game, :string
  end
end
