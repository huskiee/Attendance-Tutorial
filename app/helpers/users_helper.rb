module UsersHelper
  ## 9.2.3 基本表示用ヘルパーを作る
  # 勤怠基本情報を指定のフォーマットで返します。  
  def format_basic_info(time)
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
end
