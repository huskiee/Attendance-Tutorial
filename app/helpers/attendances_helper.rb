module AttendancesHelper
  
  ##10.6.1 退勤ボタンを表示/退勤登録ボタン
  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end
  ##<!-- 10.8 在社時間を計算 -->
  def working_times(start, finish)
    format("%.2f", (((finish - start ) / 60 ) / 60.0))
  end
end
