class SessionsController < ApplicationController
  
  def new
  end
  
  ## 6.2.2-1 ユーザーの検索と認証
  def create
  ## 6.2.2-2 ユーザーの検索と認証
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザー情報ページにリダイレクトします。
      ##6.3.1 ログイン用のメソッドを作ろう
      log_in user
      redirect_to user
    else
      # ここにはエラーメッセージ用のflashを入れます。
      ## 6.2.3-1 エラーメッセージを表示
      ##flash[:danger] = '認証に失敗しました。'
      ## 6.2.3-2 エラーメッセージを表示
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
  
  ##6.6 ログアウト機能を追加
  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
