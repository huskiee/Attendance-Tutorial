class AttendancesController < ApplicationController
  ## 11.1.3 勤怠情報ページのアクション作成でset_userアクションをapplicationコントローラーへ引越し、beforeフィルターの設定
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  ## 11.3.4 認可機能を追加
  before_action admin_or_correct_user, only: [update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: :edit_one_month
  
  ##<!-- 10.6.2 updateアクションを完成/退勤登録ボタン -->
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
  ##10.5.3 出勤登録アクションを作る/出勤登録ボタン
  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      ##10.5.3-2 出勤登録アクションを作る/出勤登録ボタン
      ##if @attendance.update_attributes(started_at: Time.current)
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        ##flash[:danger] = "勤怠登録に失敗しました。やり直してください。"
        ##<!-- 10.6.2 updateアクションを完成/退勤登録ボタン -->
        flash[:danger] = UPDATE_ERROR_MSG
      end
    ##<!-- 10.6.2 updateアクションを完成/退勤登録ボタン -->
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  ## 11.1.3 勤怠編集ページのアクション作成
  def edi_one_month 
  end
  
  ## 11.1.4 勤怠編集ページの更新アクション作成
  def update_one_month
    ## 11.3.2 例外処理を含めた更新を追加
     # トランザクションを開始します。
    ActiveRecord::Base.transaction do
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
    end
    ## 11.3.2-2 例外処理を含めた更新を追加
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
   # トランザクションによるエラーの分岐です。
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end
  ## 11.2 StrongParametersの応用
  private
    # 1ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
  
  ## 11.3.4 認可機能を追加
  # 管理権限者、または現在ログインしているユーザーを許可します。
  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[danger] = "編集権限がありません。"
      redirect_to(root_url)
    end
  end
end
