module ScoresHelper
  def weekly_average
    week_scores = current_user.scores.where("day > ?", Date.today - Date.today.wday)
    if week_scores.count == 0
      return nil
    else
      return week_scores.sum("value").to_f / week_scores.count
    end
  end

  def daily_average
    daily_scores = current_user.scores.where(day: Date.today)
    if daily_scores.count == 0
      return nil
    else
      return daily_scores.sum("value").to_f / daily_scores.count
    end
  end

  def monthly_average
    monthly_scores = current_user.scores.where("day >= ?", Date.new(Date.today.year, Date.today.month, 1))
    if monthly_scores.count == 0
      return nil
    else
      return monthly_scores.sum("value").to_f / monthly_scores.count
    end
  end

end
