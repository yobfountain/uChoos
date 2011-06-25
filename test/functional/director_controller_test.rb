require 'test_helper'

class DirectorControllerTest < ActionController::TestCase
  test "should get route" do
    get :route
    assert_response :success
  end

end
