class ApiController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
  def twilio_voice
    user = User.find_by_mobile_number(params[:From])
    mobile_number = params[:From]
    if user.nil?
      user = User.new
      user.mobile_number = mobile_number
      user.save!
      redirect_to '/static/new_user.xml'
    else
      if user.last_game and user.last_scene
        redirect_to '/static/games/' + user.last_game + '/scenes/' + user.last_scene + '.xml'
      else
        redirect_to '/static/games/1/scenes/001.xml'
      end
    end
  end

  # GET /apis/1
  # GET /apis/1.xml
  def twilio_sms
    true
  end

end
