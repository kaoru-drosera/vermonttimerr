require "test_helper"

class TimerpostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # @number = Faker::Number.leading_zero_number(digits: 3)
    @timerpost = @user.timerposts.build(hour:1, minutes:1, second:1, memo:"Lorem ipsum", title:"title")
  end

  test "should be valid" do
    assert @timerpost.valid?
  end

  test "user id should be valid" do
    @timerpost.user_id = nil
    assert_not @timerpost.valid?
  end

  # 投稿が空白でないかどうか
  test "hour should be present" do
    @timerpost.hour = ""
    assert_not @timerpost.valid?
  end

  test "minutes should be present" do
    @timerpost.minutes = ""
    assert_not @timerpost.valid?
  end

  test "second should be present" do
    @timerpost.second = ""
    assert_not @timerpost.valid?
  end

  # 投稿が2桁を超えないかどうか
  test "hour should be 2 digits" do
    @timerpost.hour = 111
    assert_not @timerpost.valid?
  end

  test "minutes should be 2 digits" do
    @timerpost.minutes = 111
    assert_not @timerpost.valid?
  end

  test "second should be 2 digits" do
    @timerpost.second = 111
    assert_not @timerpost.valid?
  end

  # 投稿が60を超えないかどうか
  test "hour should be 0..60" do
    @timerpost.hour = 61
    assert_not @timerpost.valid?
  end

  test "minutes should be 0..60" do
    @timerpost.minutes = 61
    assert_not @timerpost.valid?
  end

  test "second should be 0..60" do
    @timerpost.second = 61
    assert_not @timerpost.valid?
  end

  test "order should be most recent first" do
    assert_equal timerposts(:two_most_secent), Timerpost.first
  end


  # test "the truth" do
  #   assert true
  # end
end
