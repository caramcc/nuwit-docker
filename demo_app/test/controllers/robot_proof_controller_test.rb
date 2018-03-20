require 'test_helper'

class RobotProofControllerTest < ActionDispatch::IntegrationTest
  test "should get name" do
    get robot_proof_name_url
    assert_response :success
  end

end
