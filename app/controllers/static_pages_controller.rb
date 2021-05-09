class StaticPagesController < ApplicationController
  def home

    # @micropost = current_user.timerposts.build if logged_in?

    if logged_in?
      @timerpost = current_user.timerposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about

  end

  def contact

  end
end
