class ApplicationController < ActionController::Base
  def hello
    render html: "<p>hello world.</p>"
  end

  include SessionsHelper

  private

    # ログイン済みユーザーかどうか検証
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "please log in."
        redirect_to login_url
      end
    end


end
