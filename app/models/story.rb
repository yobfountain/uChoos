class Story < ActiveRecord::Base
  
  belongs_to :user
  has_many :scenes, :order => "id ASC"
    
end
