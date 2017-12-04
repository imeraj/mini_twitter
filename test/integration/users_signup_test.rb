require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
      get signup_path
      assert_no_difference 'User.count' do
          post users_path, params: {
            user: {
              name: "",
              email: "user@invlaid",
              password: "foo",
              password_confirmation: "bar"
            }
          }
      end
      assert_template 'users/new'
      assert_select 'div#error_explanation'
      assert_select 'div.field_with_errors'
  end

  test "valid signup information with account activation" do
      get signup_path
      assert_difference 'User.count', 1 do
          post users_path, params: {
              user: {
                name:  "Test User",
                email: "test@example.com",
                password: 'password',
                password_confirmation: 'password'
              }
          }
      end

      assert_equal 1, Sidekiq::Worker.jobs.size
      user = assigns(:user)
      assert_not user.activated?
      log_in_as(user)
      assert_not logged_in?

      get edit_account_activation_path("invalid token", email: user.email)
      assert_not logged_in?

      get edit_account_activation_path(user.activation_token, email: "wrong")
      assert_not logged_in?

      get edit_account_activation_path(user.activation_token, email: user.email)
      assert user.reload.activated?
      follow_redirect!
      assert_template 'users/show'
      assert logged_in?
  end

end
