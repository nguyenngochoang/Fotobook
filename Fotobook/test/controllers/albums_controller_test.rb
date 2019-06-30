require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get myalbum" do
    get albums_myalbum_url
    assert_response :success
  end

end
