module SessionsHelper
  
  ##6.3.1 ログイン用のメソッドを作ろう
  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user)
    session[:user_id] = user.id
  end
  
  ## 7.1.3 ログイン状態の永続的保持
  # 永続的セッションを記憶します（Userモデルを参照）
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  ## 7.1.4 ユーザーの記憶を忘れる
  # 永続的セッションを破棄します
  def forget(user)
    user.forget # Userモデル参照
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  ##6.6 ログアウト機能を追加
  # セッションと@current_userを破棄します
  def log_out
    ##session.delete(:user_id)
    ## 7.1.4 ユーザーの記憶を忘れる
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  ##6.3.2 current_userを定義
  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user
    ## 8.2.2 正しいユーザーであることを要求
    ##if session[:user_id]
    if (user_id = session[:user_id])
      ##@current_user ||= User.find_by(id: session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    ## 7.1.3 ログイン状態の永続的保持
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  ## 8.2.2 正しいユーザーであることを要求する
  # 渡されたユーザーがログイン済みのユーザーであればtrueを返します。
  def current_user?(user)
    user == current_user
  end
   
  ##6.4.1 レイアウトのログイン＆ログアウト仕様に対応
  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
    !current_user.nil?
  end
  
  ## 8.3 フレンドリーフォワーディング(親切な転送（リダイレクト）)機能を追加
  # 記憶しているURL(またはデフォルトURL)にリダイレクトします。
  def redirect_back_or(default_url)
    redirect_to(session[:forwarding_url] || default_url)
    session.delete(:forwarding_url)
  end

  ## 8.3 フレンドリーフォワーディング(親切な転送（リダイレクト）)機能を追加
  # アクセスしようとしたURLを記憶します。
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end