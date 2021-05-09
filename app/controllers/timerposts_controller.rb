class TimerpostsController < ApplicationController
  before_action :logged_in_user, only:[:create, :destroy]
  before_action :correct_user, only:[:destroy]

  def create
    @timerpost = current_user.timerposts.bulid(timerpost_params)
    if @timerpost.save
      flash[:success] = "Timerpost created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params:[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @timerpost.destroy
    flash[:success] = "are you delete this timerpost?"
    redirect_to request.referrer || root_url
  end

  private

    def timerpost_params
      params.requite(:timerpost).permit(:hour, :minutes, :second)
    end

    def correct_user
      @timerpost = current_user.timerposts.find_by(id: params[:id])
      redirect_to root_url if @timerpost.nil?
    end

end
