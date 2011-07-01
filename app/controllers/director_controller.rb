class DirectorController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # hard coded directions for prototype
  DIRECTIONS = { 
    '001' => {'1' => '002','2' => '003'}, 
    '002' => {'1' => '004','2' => '005'},
    '003' => {'1' => '002','2' => '001'},
    '004' => {'1' => '007','2' => '006'},
    '005' => {'1' => '001','2' => '003'},
    '006' => {'1' => '007','2' => '003'},
    '007' => {'1' => '008','2' => '009'},
    '008' => {'1' => '001','2' => '001'},
    '009' => {'1' => '008','2' => '001'},
  }

  #TODO catch exception for when there is no scene for that game
  def router
    story = Story.find_by_id(params[:story])
    scene = params[:scene]
    scene_index = scene.to_i - 1
    digits = params[:Digits]
    user = User.find_by_mobile_number(params[:From])
    redirect = ""

    if digits
      if digits == "1"
        next_scene = story.scenes[scene_index].option_one.to_s
      elsif digits == "2"
        next_scene = story.scenes[scene_index].option_two.to_s
      else
        next_scene = nil
      end
      return
    else
      render_scene(story, scene)
      return
    end

    if next_scene
      user.save_progress!(story, next_scene)
      render_scene(story, next_scene)
      return
    else
      redirect = "/director/choice/#{story.id.to_s}/#{scene.to_s}"
      # create repsonse
      @r = Twilio::Response.new
      # wrap with gather tag
      @r.append(Twilio::Say.new("I didn't understand your response!", :voice => "man"))
      # redirect to choice menu    
      @r.append(Twilio::Redirect.new(redirect, :method => "GET"))

      puts "Unknown Choice: " + @r.respond
      render :xml => @r.respond
      return
    end
  end

  def story_menu
    @r = Twilio::Response.new
    @r.append(Twilio::Play.new("/static/game_menu.mp3"))
    @r.append(Twilio::Redirect.new("/director/router/1/1", :method => "GET"))
    puts "Boom: " + @r.respond
    render :xml => @r.respond
    return
  end

  def set_sms
    digits = params[:Digits]
    user = User.find_by_mobile_number(params[:From])
    twilio_number = params[:To]

    if digits == "1"
      user.can_text = true
      user.save
      puts 'sms: true'

      if twilio_number == STAGING_NUMBER
        render 'director/story_menu.xml'
      else
        redirect_to '/static/game_menu.xml'
      end
    elsif digits == "2"
      user.can_text = false
      user.save
      puts 'sms: false'
      if twilio_number == STAGING_NUMBER
        render 'director/story_menu.xml'
      else
        redirect_to '/static/game_menu.xml'
      end
    else
      #TODO make this more intelligent
      redirect_to '/static/check_sms.xml'
    end
  end

  def render_scene(story, scene)
    route = "director/router/" + story.id.to_s + "/" + scene
    redirect = "director/choice/" + story.id.to_s + "/" + scene
    choiceless_redirect = "director/router/" + story.id.to_s + "/" + story.scenes[scene.to_i - 1].option_one.to_s
    # create repsonse
    @r = Twilio::Response.new
    # play scene audio
    @r.append(Twilio::Play.new(story.scenes[scene.to_i - 1].scene_audio))
    
    # Check to see if the scene only has one path
    if story.scenes[scene.to_i - 1].choiceless?
      @r.append(Twilio::Redirect.new(choiceless_redirect, :method => "GET"))
      puts "Choiceless: " + @r.respond
    elsif story.scenes[scene.to_i - 1].final?
      @r.append(Twilio::Sms.new(story.scenes[scene.to_i - 1].choice_text))
      @r.append(Twilio::Hangup.new())
      puts "Final: " + @r.respond
    else
      # wrap with gather tag
      @g = @r.append(Twilio::Gather.new(:numDigits => "1", :action => route, :method => "GET", :timeout => "6"))
      # play choice audio
      @g.append(Twilio::Play.new(story.scenes[scene.to_i - 1].choice_audio))
      # add response for no answer
      @r.append(Twilio::Say.new("Please enter a choice!", :voice => "man"))
      # redirect to choice menu    
      @r.append(Twilio::Redirect.new(redirect, :method => "GET"))
      puts "Scene: " + @r.respond
    end

    render :xml => @r.respond
  end

  def render_choice
    story = Story.find_by_id(params[:story])
    scene = params[:scene]
    scene_index = scene.to_i - 1
    digits = params[:Digits]
    
    route = "director/router/" + story.id.to_s + "/" + scene
    redirect = "director/choice/" + story.id.to_s + "/" + scene
    # create repsonse
    @r = Twilio::Response.new
    # wrap with gather tag
    @g = @r.append(Twilio::Gather.new(:numDigits => "1", :action => route, :method => "GET", :timeout => "6"))
    # play choice audio
    @g.append(Twilio::Play.new(story.scenes[scene_index].choice_audio))
    # add response for no answer
    @r.append(Twilio::Say.new("Please enter a choice!", :voice => "man"))
    # redirect to choice menu    
    @r.append(Twilio::Redirect.new(redirect, :method => "GET"))

    puts "Choice: " + @r.respond
    render :xml => @r.respond
  end
  
  def get_next_scene(digits, scene)
    if digits == "1"
      next_scene = scene.option_one
    elsif digits == "2"
      next_scene = scene.option_two
    else
      next_scene = nil
    end
    next_scene
  end
  
  # TODO delete after building alternate system
  def route
    game = params[:game]
    scene = params[:scene]
    digits = params[:Digits]
    user = User.find_by_mobile_number(params[:From])

    next_scene = DIRECTIONS[scene][digits]

    if next_scene
      user.update_progress!(game, next_scene)
      redirect_to '/static/games/1/scenes/' + next_scene + '.xml'
    else
      @scene = scene
      render 'director/bad.xml'
    end
  end
  

end
