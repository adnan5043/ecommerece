require 'test_helper'

class OrderTransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get order_transactions_destroy_url
    assert_response :success
  end

end
