class ApplicationController < ActionController::Base
  protect_from_forgery
  
  PRODUCTION_NUMBER = ENV['UCHOOS_PRODUCTION_NUMBER'] || raise("Please set twilio phone number")
  # STAGING_NUMBER = ENV['UCHOOS_STAGING_NUMBER'] || raise("Please set twilio staging number")
  
end
