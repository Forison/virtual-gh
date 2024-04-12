require 'test_helper'

class SelfLearnsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get self_learns_index_url
    assert_response :success
  end
end
