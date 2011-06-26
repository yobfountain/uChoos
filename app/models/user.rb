class User < ActiveRecord::Base
  
  def update_progress!(game, next_scene)
    self.last_scene = next_scene
    self.last_game = game
    self.save
  end
  
  #def to_s
  #  number_to_phone(self.mobile_number.to_i) if self.mobile_number
  #end
  
end
