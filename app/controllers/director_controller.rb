class DirectorController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  DIRECTIONS = { '001' => {'1' => '002','2' => '003'}, 
                 '002' => {'1' => '001','2' => '003'},
                 '003' => {'1' => '001','2' => '002'}
               }
  
  def route
    origin = params[:origin]
    digits = params[:Digits]
    
    puts 'origin: ' + origin
    puts 'destination: ' + digits

    next_room = DIRECTIONS[origin][digits]
    
    if next_room
      redirect_to '/static/demo/rooms/' + next_room + '.xml'
    else
      @origin = origin
      render 'director/bad.xml'
    end
  end

end
