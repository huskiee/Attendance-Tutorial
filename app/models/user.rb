class User < ApplicationRecord
  ## 7.1.2 rememberメソッドを作る
  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  ## 9.1.1 「department（所属）」カラムのバリデーションを設定
  validates :department, length: { in: 2..30 }, allow_blank: true
  ## 9.2.1 勤怠基本情報のバリデーションを設定
  validates :basic_time, presence: true
  validates :work_time, presence: true
  has_secure_password
  ## 8.1.4 パスワードはスルーして更新できるようにする
  ##validates :password, presence: true, length: { minimum: 6 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  ## 7.1.1 ランダムな文字列を作る
  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  ## 7.1.1 ランダムな文字列を作る
  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  ## 7.1.2 rememberメソッドを作る
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  ## 7.1.3 ログイン状態の永続的保持
    # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    ## 7.2 ふたつの小さなバグを直す
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  ## 7.1.4 ユーザーの記憶を忘れる
  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end
