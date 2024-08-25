require "test_helper"

class WinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wines = create_list(:wine, 10)
  end

  test "should get index" do
    get wines_url
    assert_response :success
  end

  test "should get show" do
    get wine_url(@wines.first)
    assert_response :success
  end
end
