class UsersController < ApplicationController
  # index(ユーザー一覧ページはログインなしでも見られるものを設定してみたい)
  before_action :logged_in_user, only:[:edit, :update, :index, :destroy]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin_user, only: :destroy


  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @timerposts = @user.timerposts.paginate(page: params[:page])

    # debugger
  end

  def new
    @user = User.new
    # debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #登録成功時の処理
      log_in @user
      flash[:success] = "ユーザー登録成功"
      redirect_to user_url(@user)
    else
      # 登録失敗時の処理
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新成功時の処理を扱う
      flash[:success] = "profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "delete this user?"
    redirect_to users_url
  end

  private

    def user_params
      # パラメータ取得変数
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeアクション

    # # ログイン済みユーザーかどうか検証
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "please log in."
    #     redirect_to login_url
    #   end
    # end

    def correct_user
      @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者ユーザーかどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


end
