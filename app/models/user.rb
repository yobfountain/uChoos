class User < ActiveRecord::Base
  
  def update_progress!(game, next_room)
    self.last_scene = next_room
    self.last_game = game
    self.save
  end
  
end
