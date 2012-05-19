class Story < ActiveRecord::Base
  
  belongs_to :user
  has_many :scenes, :order => "id ASC"
  
  validates_uniqueness_of :keyword, :name
  validates_presence_of :keyword, :name  
    
end
