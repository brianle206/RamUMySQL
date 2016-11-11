require 'test_helper'

class EnrollmentControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
