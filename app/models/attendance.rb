class Attendance < ApplicationRecord
  belongs_to :user
  
  ##10.1.2 バリデーションを設定(勤怠情報表示ページ)
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  ##10.1.3 カスタムメソッドを作ろう(勤怠情報表示ページ)
  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at

  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
end