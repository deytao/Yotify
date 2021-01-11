require 'test_helper'

class OauthControllerTest < ActionDispatch::IntegrationTest
  test "should get token" do
    get oauth_token_url
    assert_response :success
  end

end
