require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  # 有効なユーザーかどうか
  test "user should be vaild" do
    assert @user.valid?
  end

  # 名前/メールアドレスが無記入でないかどうか
  test "user name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "user email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  #長すぎる名前/メールアドレスでないかどうか
  test "name should not be so long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be so long" do
    @user.email = "a" * 224 + "@example.com"
    assert_not @user.valid?
  end

  # 有効なメールアドレスかどうか
  test "email validation should accept valid addresses" do
    valid_addresses = %w[USERS@foo.COM THE_US_ER@foo.bar.org first.last@foo.jp]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # 無効なメールアドレスを弾くかどうか
  test "email validation should reject invalid address" do
    invalid_addresses = %w[user@example,com user_at_foo.org foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?,"#{invalid_address.inspect} should be invalid"
    end
  end

  # 重複するメールアドレスを弾くかどうか
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    # duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # メールアドレスを小文字のみで保存するように調整する
  test "email address should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present(nonblank)" do
    @user.password = @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test 'anthenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?('')
  end

end
