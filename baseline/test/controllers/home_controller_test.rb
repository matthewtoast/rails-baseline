require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'should get index' do
    sign_in user
    get root_url
    assert_response :success
  end
end
