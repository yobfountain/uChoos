class DirectorController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  # DIRECTIONS = [ 001 => ['002', '003'], 002 => ['001', '003'], 003 => ['001', '002'] ]
  
  def route
    origin = params[:origin]
    destination = params[:Digits]
    
    case origin
    when "001" && destination == "1"
      redirect_to "/static/demo/rooms/002.xml"
    when "001" && destination == "2"
      redirect_to "/static/demo/rooms/003.xml"
    when "002" && destination == "1"
      redirect_to "/static/demo/rooms/001.xml"
    when "002" && destination == "2"
      redirect_to "/static/demo/rooms/003.xml"
    when "003" && destination == "1"
      redirect_to "/static/demo/rooms/001.xml"
    when "003" && destination == "2"
      redirect_to "/static/demo/rooms/002.xml"
    end
    
  end

end
