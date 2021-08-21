class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      ## 7.1.3 ログイン状態の永続的保持
      ##remember user
      ## 7.3 チェックボックスを追加
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      ## 8.3 フレンドリーフォワーディング(親切な転送（リダイレクト）)機能を追加
      ##redirect_to user
      redirect_back_or user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end

  def destroy
    ## log_out
    ## 7.2 ふたつの小さなバグを直す
    # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end