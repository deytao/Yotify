require 'test_helper'

class SigninPageControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get signin_page_form_url
    assert_response :success
  end

end
