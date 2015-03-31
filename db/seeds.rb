# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'benchmark'

def sql
  ActiveRecord::Base.connection
end


puts Benchmark.measure{
  sql.execute "TRUNCATE schools"
  sql.execute <<-SQL
  LOAD DATA INFILE "#{Rails.root.join('db','seeds','DOE_High_School_Directory_2014-2015.csv')}"
  INTO TABLE schools
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (dbn,name, boro, building,@x,@x,starting_grade, finishing_grade,@x,@x,@x,@x,@address,@city,@state,@zip,website,@total_students,@x,school_type,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@location)
  SET
    total_students = REPLACE(@total_students,'N/A', 1),
    address = concat(@address, ', ', @city, ', ', @state, ' ', @zip),
    latitude = SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@location, "(", -1),")",""), ',', 1),
    longitude =   SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@location, "(", -1),")",""), ',', -1)
  SQL
}

puts Benchmark.measure{
  sql.execute "TRUNCATE performances"
  sql.execute <<-SQL
  LOAD DATA INFILE "#{Rails.root.join('db','seeds','DOE_High_School_Performance-Directory_2014-2015.csv')}"
  INTO TABLE performances
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (dbn, @on_track_2013, @grad_rate_2013, @college_rate_2013, @student_satisfaction, @on_track_2012, @grad_rate_2012,  @college_rate_2012, @student_satisfation_2012, @on_track_sim_schools, @grad_rate_sim_schools, @college_rate_sim_schools, @student_satisfaction_sim_schools, quality_review, @x)
  SET
    on_track_2013 = IF(@on_track_2013 = "N/A", NULL, REPLACE(@on_track_2013, "%", '') / 100),
    grad_rate_2013 = IF(@grad_rate_2013 = "N/A", NULL, REPLACE(@grad_rate_2013, "%", '') / 100),
    college_rate_2013 = IF(@college_rate_2013 = "N/A", NULL, REPLACE(@college_rate_2013, "%", '') / 100),
    student_satisfaction = IF(@student_satisfaction = "N/A", NULL, REPLACE(@student_satisfaction, "%", '')),
    on_track_2012 = IF(@on_track_2012 = "N/A", NULL, REPLACE(@on_track_2012, "%", '') / 100),
    grad_rate_2012 = IF(@grad_rate_2012 = "N/A", NULL, REPLACE(@grad_rate_2012, "%", '') / 100),
    college_rate_2012 = IF(@college_rate_2012 = "N/A", NULL, REPLACE(@college_rate_2012, "%", '') / 100),
    student_satisfation_2012 = IF(@student_satisfation_2012 = "N/A", NULL, REPLACE(@student_satisfation_2012, "%", '')),
    on_track_sim_schools = IF(@on_track_sim_schools = "N/A", NULL, REPLACE(@on_track_sim_schools, "%", '') / 100),
    grad_rate_sim_schools = IF(@grad_rate_sim_schools = "N/A", NULL, REPLACE(@grad_rate_sim_schools, "%", '') / 100),
    college_rate_sim_schools = IF(@college_rate_sim_schools = "N/A", NULL, REPLACE(@college_rate_sim_schools, "%", '') / 100),
    student_satisfaction_sim_schools = IF(@student_satisfaction_sim_schools = "N/A", NULL, REPLACE(@student_satisfaction_sim_schools, "%", ''))
  SQL
}

puts Benchmark.measure{
  sql.execute "TRUNCATE after_school_programs"
  sql.execute <<-SQL
  LOAD DATA INFILE "#{Rails.root.join('db','seeds','DYCD_after-school_programs.csv')}"
  INTO TABLE after_school_programs
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (program, program_type, site, boro, agency, @x, grade_age_level, @loc)
  SET
    latitude = IF(@loc = "", NULL, SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@loc, "(", -1),")",""), ',', 1)),
    longitude =  IF(@loc = "", NULL, SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@loc, "(", -1),")",""), ',', -1))
  SQL
}

puts Benchmark.measure{
  sql.execute "TRUNCATE safety_reports"
  sql.execute <<-SQL
  LOAD DATA INFILE "#{Rails.root.join('db','seeds','School_Safety_Report.csv')}"
  INTO TABLE safety_reports
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@id, building, dbn, @name, @code, @add, @boro, @geo, @reg, @bname, @schools, @inbldg, @major_crimes, @other_crimes, @incidents, @property_crimes, @violent_crimes, group_size, @range, @avg_major_crimes, @avg_other_crimes, @avg_incidents, @avg_property_crimes, @avg_violent_crimes)
  SET
    major_crimes = REPLACE(@major_crimes, "N/A", NULL),
    other_crimes = REPLACE(@other_crimes, "N/A", NULL),
    incidents = REPLACE(@incidents, "N/A", NULL),
    property_crimes = REPLACE(@property_crimes, "N/A", NULL),
    violent_crimes = REPLACE(@violent_crimes, "N/A", NULL),
    avg_major_crimes = REPLACE(@avg_major_crimes, "N/A", NULL),
    avg_other_crimes = REPLACE(@avg_other_crimes, "N/A", NULL),
    avg_incidents = REPLACE(@avg_incidents, "N/A", NULL),
    avg_property_crimes = REPLACE(@avg_property_crimes, "N/A", NULL),
    avg_violent_crimes = REPLACE(@avg_violent_crimes, "N/A", NULL)
  SQL
}