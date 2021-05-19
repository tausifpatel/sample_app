require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do 
    get signup_path
    assert_no_difference "User.count" do 
      post users_path, params: { user: { name: "", 
                                         email: "hello@",
                                         password: "123",
                                         password_confirmation: "456" }}
    end 
    assert_template 'users/new'
  end 

  test "valid signup information" do 
    get signup_path
    assert_difference "User.count", 1 do 
      post users_path, params: { user: { name:  "Michael", 
                                         email: "Michael@gmail.com",
                                         password:              "123456",
                                         password_confirmation: "123456" }}
    end 
    follow_redirect!
    assert_template 'users/show'
  end 

  test "valid signup information shows alert message" do 
    get signup_path
    assert_difference "User.count", 1 do 
      post users_path, params: { user: { name:  "Michael", 
                                         email: "Michael@gmail.com",
                                         password:              "123456",
                                         password_confirmation: "123456" }}
    end 
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty? 
    assert is_logged_in?  #checking if user logged in right after signing up. the method is defined in helper test.
  end 
end
