require 'test_helper'

class WalletsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallet = wallets(:one)
  end

  test "should get index" do
    get wallets_url, as: :json
    assert_response :success
  end

  test "should create wallet" do
    assert_difference('Wallet.count') do
      post wallets_url, params: { wallet: { company_id: @wallet.company_id, portfolio_id: @wallet.portfolio_id, enabled: @wallet.enabled, rate: @wallet.rate } }, as: :json
    end

    assert_response 201
  end

  test "should show wallet" do
    get wallet_url(@wallet), as: :json
    assert_response :success
  end

  test "should update wallet" do
    patch wallet_url(@wallet), params: { wallet: { company_id: @wallet.company_id, portfolio_id: @wallet.portfolio_id, enabled: @wallet.enabled, rate: @wallet.rate } }, as: :json
    assert_response 200
  end

  test "should destroy wallet" do
    assert_difference('Wallet.count', -1) do
      delete wallet_url(@wallet), as: :json
    end

    assert_response 204
  end
end
