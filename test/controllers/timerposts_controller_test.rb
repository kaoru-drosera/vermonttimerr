require "test_helper"

class TimerpostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @timerpost = timerposts(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Timerpost.count' do
      post timerpost_path, params:{timerpost:{hour: 0, minutes:1, second: 30}}
    end
    assert_redirected_to login_url
  end

  test "should redirect destrpy when not logged in" do
    assert_no_difference 'Timerpost.count' do
      delete timerpost_path(@timerpost)
    end
  end

  test "should redirect destroy for wrong timerpost" do
    log_in_as(users(:michael))
    micropost = microposts(:six)
    assert_no_difference 'Timerpost.count' do
      delete micropost_path(timerpost)
    end
    assert_redirected_to root_url
  end


end
