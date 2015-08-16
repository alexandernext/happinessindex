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

  def weekly_average_scores
    if !user_signed_in?
      return nil
    end
    week_scores = current_user.scores.where("day > ?", Date.today - 7)
    week_days = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    week_count = [0,0,0,0,0,0,0]

    week_averages = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]

    week_scores.each do |score|
      week_days[score.day - Date.today + 6] += score.value
      week_count[score.day - Date.today + 6] += 1
    end
    for i in 0..6
      if week_days[i] != 0.0
        week_averages[i] = week_days[i] / week_count[i]
      end
    end
    return week_averages
  end

  def weekly_chart
    return Gchart.bar(  :size => '300x200',
              :data => weekly_average_scores,
              :bar_colors => '00B16A',
              :labels => [(Date.today - 6).day, (Date.today - 5).day, (Date.today - 4).day, (Date.today - 3).day, (Date.today - 2).day, (Date.today - 1).day, Date.today.day],
              :axis_with_labels => ['x', 'y'],
              :axis_range => [[(Date.today - 6).day, Date.today.day, 1], [0, weekly_average_scores.max, 1]])
  end
end
