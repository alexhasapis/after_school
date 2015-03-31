json.array!(@after_school_programs) do |after_school_program|
  json.extract! after_school_program, :id, :program, :program_type, :site, :boro, :agency, :grade_age_level, :latitude, :longitude
  json.url after_school_program_url(after_school_program, format: :json)
end
