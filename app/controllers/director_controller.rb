class DirectorController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  DIRECTIONS = { '001' => {'1' => '002','2' => '003'}, 
                 '002' => {'1' => '001','2' => '003'},
                 '003' => {'1' => '001','2' => '002'}
               }
  
  def route
    game = params[:game]
    scene = params[:scene]
    digits = params[:Digits]
    user = User.find_by_mobile_number(params[:From])
    
    # puts 'game: ' + game + '| scene: ' + scene + '| destination: ' + digits
    # puts 'from: ' + user

    next_room = DIRECTIONS[scene][digits]
    
    if next_room
      user.update_progress!(game, next_room)
      redirect_to '/static/games/1/scenes/' + next_room + '.xml'
    else
      @scene = scene
      render 'director/bad.xml'
    end
  end
  
  def set_sms
    digits = params[:Digits]
    user = User.find_by_mobile_number(params[:From])
  
    if digits == "1"
      user.can_text = true
      user.save
      render 'static/game_menu.xml'
    elsif digits == "2"
      user.can_text = false
      user.save
      render 'static/game_menu.xml'
    else
      #TODO make this more intelligent
      render 'static/check_sms.xml'
    end
  end
  
  def update_progress!(game, next_room)
    self.last_scene = next_room
    self.last_game = game
    self.save
  end

end
