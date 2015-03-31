json.array!(@safety_reports) do |safety_report|
  json.extract! safety_report, :id, :building, :dbn, :major_crimes, :other_crimes, :incidents, :property_crimes, :violent_crimes, :group_size, :avg_major_crimes, :avg_other_crimes, :avg_incidents, :avg_property_crimes, :avg_violent_crimes
  json.url safety_report_url(safety_report, format: :json)
end
