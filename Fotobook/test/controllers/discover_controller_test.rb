require 'test_helper'

class DiscoverControllerTest < ActionDispatch::IntegrationTest
  test "should get discover" do
    get discover_discover_url
    assert_response :success
  end

end
