require "test_helper"

class KriptoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kripto_index_url
    assert_response :success
  end
end
