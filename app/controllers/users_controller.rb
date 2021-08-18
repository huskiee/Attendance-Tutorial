class UsersController < ApplicationController
  
  ## 5.2 Usersリソース(findメソッドを使ってユーザーオブジェクトを取得してインスタンス変数を代入)
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new # 5.5 ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      ## 5.5.6 サクセスメッセージを表示
      flash[:success] = '新規作成に成功しました。'
      ## 5.5.5 ユーザーを保存
      redirect_to @user
    else
      render :new
    end
  end
  
  ## 5.5.3 Strong Parameters  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
