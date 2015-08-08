module ScoresHelper
  def weekly_average
    if !user_signed_in?
      return nil
    end
    week_scores = current_user.scores.where("day > ?", Date.today - 7)
    if week_scores.count == 0
      return nil
    else
      return week_scores.sum("value").to_f / week_scores.count
    end
  end

  def daily_average
    if !user_signed_in?
      return nil
    end
    daily_scores = current_user.scores.where(day: Date.today)
    if daily_scores.count == 0
      return nil
    else
      return daily_scores.sum("value").to_f / daily_scores.count
    end
  end

  def monthly_average
    if !user_signed_in?
      return nil
    end
    monthly_scores = current_user.scores.where("day >= ?", Date.today - 30)
    if monthly_scores.count == 0
      return nil
    else
      return monthly_scores.sum("value").to_f / monthly_scores.count
    end
  end

  def color(score)
    case score.round(0)
    when 1..5
      return "#e74c3c"
    when 6..10
      return "#00B16A"
    else
      return "#000000"
    end
  end
end
