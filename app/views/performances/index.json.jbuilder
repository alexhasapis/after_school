json.array!(@performances) do |performance|
  json.extract! performance, :id, :dbn, :on_track_2013, :grad_rate_2013, :college_rate_2013, :student_satisfaction, :on_track_2012, :grad_rate_2012, :college_rate_2012, :student_satisfation_2012, :on_track_sim_schools, :grad_rate_sim_schools, :college_rate_sim_schools, :student_satisfaction_sim_schools, :quailty_review
  json.url performance_url(performance, format: :json)
end
