class User < ActiveRecord::Base
  
  has_many :stories
  
  def update_progress!(game, next_scene)
    self.last_scene = next_scene
    self.last_game = game
    self.save
  end
  
end
