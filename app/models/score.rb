class Score < ActiveRecord::Base
  belongs_to :user
  validates :value, presence: true, numericality: { :only_integer => true, :less_than_or_equal_to => 10, :greater_than_or_equal_to => 1}
  validates :time_of_day, presence: true, inclusion: { in: %w(morning afternoon evening) }, uniqueness: { scope: :day }
  validates :description, presence: true
  validates :user, presence: true
  validates :day, presence: true

  def time_text(score)
    case score.time_of_day
    when "morning"
      return "早上"
    when "afternoon"
      return "下午"
    when "evening"
      return "晚上"
    end
  end

end
