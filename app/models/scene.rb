class Scene < ActiveRecord::Base
  
  belongs_to :story
  
  def choiceless?
    self.option_two == nil
  end
  
  def final?
    self.option_two == nil && self.option_one == nil
  end
  
end
