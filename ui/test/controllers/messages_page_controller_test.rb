require 'test_helper'

class MessagesPageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get messages_page_index_url
    assert_response :success
  end

end
