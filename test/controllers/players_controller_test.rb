require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get switch" do
    get players_switch_url
    assert_response :success
  end
end
