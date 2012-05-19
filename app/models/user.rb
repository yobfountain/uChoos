class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :mobile_number, :id
    
  has_many :stories
  
  validates_uniqueness_of :mobile_number, :name
  
  def save_progress!(story, next_scene)
    puts 'setting saved progress'
    self.last_scene = next_scene
    self.last_game = story.id
    self.save
  end
  
end
