EMAIL_ADDRESS = ENV['UCHOOS_EMAIL_ADDRESS'] || raise("Please set email address")
EMAIL_PASSWORD = ENV['UCHOOS_EMAIL_PASSWORD'] || raise("Please set email password")

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'gmail.com',
  :authentication => :plain,
  :user_name => EMAIL_ADDRESS,
  :password => EMAIL_PASSWORD
}