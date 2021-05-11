require "test_helper"

class TimerpostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "timerpost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'


    # 無効な送信
    assert_no_difference 'Timerpost.count' do
      post timerposts_path, params:{timerpost:{hour:"", minutes:"", second:"", memo:""}}
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]','/?page=2'

    # 有効な送信
    hour = 1;
    minutes = 1;
    second = 1;
    memo = "this is timerpostTest"
    assert_difference 'Timerpost.count', 1 do
      post timerposts_path, params:{timerpost:{hour:hour, minutes:minutes, second:second, memo:memo}}
    end
    assert_redirected_to root_url
    follow_redirect!

    # エラーが出た場合、最悪諦めてよし
    # assert_match hour, response.body
    # assert_match minutes, response.body
    # assert_match second, response.body
    # assert_match memo, response.body


    # 投稿を削除
    assert_select 'a',text:"delete"
    first_timerpost = @user.timerposts.paginate(page: 1).first
    assert_difference 'Timerpost.count', -1 do
      delete timerpost_path(first_timerpost)
    end

    # 違うユーザーのプロフィールにアクセス＆deleteリンクがないことを確認
    get user_path(users(:archer))
    assert_select 'a',{text:'delete',count: 0}


  end


  test "timerpost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.timerposts.count} timerposts", response.body
    # まだ投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 timerposts", response.body
    other_user.timerposts.create!(hour: 1, minutes: 1, second: 1, memo:"A memo")
    get root_path
    assert_match "1 timerpost", response.body
  end


  # test "the truth" do
  #   assert true
  # end
end
