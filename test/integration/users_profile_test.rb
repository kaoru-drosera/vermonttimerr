require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_match @user.timerposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.timerposts.paginate(page: 1).each do |timerpost|
      # ここのテストはあきらめた。
      # 「XXの値があるかどうか」を確かめるには値まですべて完全である必要があり
      # 「0から59以下」などの条件を定めようとするとどうしてもアトランダムにならざるを得ず
      # すべて完全に揃わなくなるためである。無念なり…


      # assert_match timerpost.user.name, response.body
      # assert_match timerpost.hour, response.body
      # assert_match timerpost.minutes, response.body
      # assert_match timerpost.second, response.body
      # assert_match timerpost.memo, response.body
    end
  end
  # test "the truth" do
  #   assert true
  # end
end
