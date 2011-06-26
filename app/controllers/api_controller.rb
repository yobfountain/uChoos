class ApiController < ApplicationController

  def twilio_voice
    user = User.find_by_mobile_number(params[:From])
    mobile_number = params[:From]
    if user.nil?
      user = User.new
      user.mobile_number = mobile_number
      user.save!
      render 'static/new_user.xml'
    else
      if user.last_game and user.last_scene
        render 'static/games/' + user.last_game + '/scenes/' + user.last_scene + '.xml'
      else
        render 'static/games/1/scenes/001.xml'
      end
    end
  end

  # GET /apis/1
  # GET /apis/1.xml
  def twilio_sms
    true
  end

end
