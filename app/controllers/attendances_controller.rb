class AttendancesController < ApplicationController
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
end
