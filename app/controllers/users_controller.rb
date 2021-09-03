class UsersController < ApplicationController
  ## 8.2.2 正しいユーザーであることを要求する
  ##before_action :set_user, only: [:show, :edit, :update]
  ## 8.5.2 destroyアクション
  ## 9.3.1 モーダルウインドウを表示(, :edit_basic_info, :update_basic_infoの追加)
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  ## 8.2.1 ユーザーにログインを要求する
  ##before_action :logged_in_user, only: [:show, :edit, :update]
  ## 8.4 全てのユーザーを表示するページ
  ##before_action :logged_in_user, only: [:index, :show, :edit, :update]
  ## 8.5.2 destroyアクション
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  ## 8.2.2 正しいユーザーであることを要求する
  before_action :correct_user, only: [:edit, :update]
  ## 8.5.2 destroyアクション
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  ##10.3 "ユーザー"の月日を一覧表示
  before_action :set_one_month, only: :show
  
  ## 8.4 全てのユーザーを表示するページ
  def index
    ##@users = User.all
    ## 8.4.2 ページネーションを使おう
    @users = User.paginate(page: params[:page])
  end
  
  ## 5.2 Usersリソース(findメソッドを使ってユーザーオブジェクトを取得してインスタンス変数を代入)
  def show
  ## 9.3.1 モーダルウインドウを表示  
    ##@user = User.find(params[:id])
    ##10.2 月日を一覧表示しよう(勤怠情報表示ページ)
    ##10.3 "ユーザー"の月日を一覧表示
    ##@first_day = Date.current.beginning_of_month
    ##@last_day = @first_day.end_of_month
    ##<!-- 10.7 出勤日数を表示 -->
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def new
    @user = User.new # 5.5 ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      ## 6.5 ユーザー登録と同時にログインする
      log_in @user # 保存成功後、ログインします。
      ## 5.5.6 サクセスメッセージを表示
      flash[:success] = '新規作成に成功しました。'
      ## 5.5.5 ユーザーを保存
      redirect_to @user
    else
      render :new
    end
  end
  
  ## 8.1 ユーザー編集ページを作る
  def edit
    ## 9.3.1 モーダルウインドウを表示  
    ##@user = User.find(params[:id])
  end
  
  ## 8.1.2 更新に失敗した場合の処理
  def update
    ## 9.3.1 モーダルウインドウを表示  
    ##@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合の処理を記述します。
      ## 8.1.3 更新に成功した場合の処理
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
  
  ## 8.5.2 destroyアクション
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  ## 9.3.1 モーダルウインドウを表示
  def edit_basic_info
  end

  ## 9.3.1 モーダルウインドウを表示
  def update_basic_info
    ## 9.3.2 更新アクションを完成させよう
    if @user.update_attributes(basic_info_params)
      # 更新成功時の処理
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      # 更新失敗時の処理
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  
  
  ## 5.5.3 Strong Parameters  
  private

    def user_params
      ## 9.1.3 StrongParameters（user_paramsにdepartment属性を加えて対応）
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
  
    ## 9.3.2 更新アクションを完成
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
  
  
  
  
  ## 11.1.3 勤怠情報ページのアクション作成でset_userアクションをapplicationコントローラーへ引越し
  ## 8.2.1 ユーザーにログインを要求する
  # beforeフィルター
  
     ## 8.5.2 destroyアクション
    # paramsハッシュからユーザーを取得します。
    ##def set_user
      ##@user = User.find(params[:id])
    ##end

    # ログイン済みのユーザーか確認します。
    ##def logged_in_user
      ##unless logged_in?
        ## 8.5.2 destroyアクション
        ##store_location
        ##flash[:danger] = "ログインしてください。"
        ##redirect_to login_url
      ##end
    ##end
  
  ## 8.2.2 正しいユーザーであることを要求する
  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    ##def correct_user
      ##@user = User.find(params[:id])
      ## 8.2.2 正しいユーザーであることを要求する
      #redirect_to(root_url) unless @user == current_user
      ##redirect_to(root_url) unless current_user?(@user)
    ##end
  
  ## 8.5.2 destroyアクション
  # システム管理権限所有かどうか判定します。
    ##def admin_user
      ##redirect_to root_url unless current_user.admin?
    ##end

end
