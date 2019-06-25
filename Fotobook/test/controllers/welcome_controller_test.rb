require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get feeds" do
    get welcome_feeds_url
    assert_response :success
  end

end
