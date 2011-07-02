class ApiController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
  def twilio_voice
    user = User.find_by_mobile_number(params[:From])
    mobile_number = params[:From]
    twilio_number = params[:To]
    
    # Check that user exists and has sms set
    if user.nil?
      user = User.new
      user.mobile_number = mobile_number
      user.save!
      redirect_to '/static/new_user.xml'
      return
    elsif user.can_text.nil?
      redirect_to '/static/check_sms.xml'
      return
    end
    
    # route the player to the proper starting point
    if user.last_game && user.last_scene
      puts "Last Game: " + user.last_game
      puts "Last scene: " + user.last_scene
    end
    if user.last_game and !user.last_game.blank?
      puts "Redirecting to last game"
      redirect_to '/director/router/' + user.last_game + '/' + user.last_scene
    else
      # TODO fix this hack once menu is set up
      puts "No existing game found. Redirecting to story menu"
      redirect_to '/director/story_menu'
    end

  end


  def twilio_sms
    true
  end

end
