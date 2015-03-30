json.array!(@schools) do |school|
  json.extract! school, :id, :dbn, :name, :boro, :building, :starting_grade, :finishing_grade, :address, :website, :total_students, :school_type, :latitude, :longitude
  json.url school_url(school, format: :json)
end
