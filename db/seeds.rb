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

school_directory = File.read('db/seeds/schools_directory.json')

parsed_directory = JSON.parse(school_directory)

schools = parsed_directory['data']

schools.each do |school|
  School.create({
    dbn: school[8],
    name: school[9],
    boro: school[10],
    building: school[11], 
    starting_grade: school[14],
    finishing_grade: school[15],
    address: "#{school[20]}, #{school[21]}, #{school[22]} #{school[23]}",
    website: school[24],
    total_students: school[25],
    school_type: school[27],
    latitude: school[65][1],
    longitude: school[65][2]
    })
end
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
programs_directory = File.read('db/seeds/programs_directory.json')

parsed_directory = JSON.parse(programs_directory)

programs = parsed_directory['data']

programs.each do |program|
  AfterSchoolProgram.create({
    program: program[8],
    program_type: program[9],
    site: program[10],
    boro: program[11],
    agency: program[12],
    grade_age_level: program[14],
    latitude: program[15][1],
    longitude: program[15][2]
    })
end

AfterSchoolProgram.delete(1)
}

puts Benchmark.measure{
  sql.execute "TRUNCATE raw_safety_reports"
  sql.execute <<-SQL
  LOAD DATA INFILE "#{Rails.root.join('db','seeds','School_Safety_Report.csv')}"
  INTO TABLE raw_safety_reports
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (@id, building, dbn, @name, @code, @add, @boro, @geo, @reg, @bname, number_schools, @inbldg, @major_crimes, @other_crimes, @incidents, @property_crimes, @violent_crimes, @eng, group_size, @avg_major_crimes, @avg_other_crimes, @avg_incidents, @avg_property_crimes, @avg_violent_crimes)
  SET
    major_crimes = REPLACE(@major_crimes, 'N/A', 0),
    other_crimes = REPLACE(@other_crimes, 'N/A', 0),
    incidents = REPLACE(@incidents, 'N/A', 0),
    property_crimes = REPLACE(@property_crimes, 'N/A', 0),
    violent_crimes = REPLACE(@violent_crimes, 'N/A', 0),
    avg_major_crimes = REPLACE(@avg_major_crimes, 'N/A', 0),
    avg_other_crimes = REPLACE(@avg_other_crimes, 'N/A', 0),
    avg_incidents = REPLACE(@avg_incidents, 'N/A', 0),
    avg_property_crimes = REPLACE(@avg_property_crimes, 'N/A', 0),
    avg_violent_crimes = REPLACE(@avg_violent_crimes, 'N/A', 0)
  SQL
}

puts Benchmark.measure{
  sql.execute "TRUNCATE safety_reports"
  sql.execute <<-SQL
  INSERT INTO safety_reports (building, dbn, number_schools, major_crimes, other_crimes, incidents, property_crimes, violent_crimes, group_size, avg_major_crimes, avg_other_crimes, avg_incidents, avg_property_crimes, avg_violent_crimes, created_at, updated_at)
  SELECT building, dbn, COUNT(number_schools), major_crimes, SUM(other_crimes), SUM(incidents), SUM(property_crimes), SUM(violent_crimes), group_size, SUM(avg_major_crimes), SUM(avg_other_crimes), SUM(avg_incidents), SUM(avg_property_crimes), SUM(avg_violent_crimes), created_at, updated_at
  FROM raw_safety_reports
  GROUP BY building;
  SQL
  sql.execute "UPDATE safety_reports SET number_schools = 1 WHERE number_schools = 0;"
}

# puts Benchmark.measure{
#   sql.execute "TRUNCATE schools"
#   sql.execute <<-SQL
#   LOAD DATA INFILE "#{Rails.root.join('db','seeds','DOE_High_School_Directory_2014-2015.csv')}"
#   INTO TABLE schools
#   FIELDS TERMINATED BY ','
#   OPTIONALLY ENCLOSED BY '"'
#   LINES TERMINATED BY '\n'
#   IGNORE 1 LINES
#   (dbn,name, boro, building,@x,@x,starting_grade, finishing_grade,@x,@x,@x,@x,@address,@city,@state,@zip,website,@total_students,@x,school_type,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@location)
#   SET
#     total_students = REPLACE(@total_students,'N/A', 1),
#     address = concat(@address, ', ', @city, ', ', @state, ' ', @zip),
#     latitude = SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@location, "(", -1),")",""), ',', 1),
#     longitude =   SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@location, "(", -1),")",""), ',', -1)
#   SQL
# }

# puts Benchmark.measure{
#   sql.execute "TRUNCATE performances"
#   sql.execute <<-SQL
#   LOAD DATA INFILE "#{Rails.root.join('db','seeds','DOE_High_School_Performance-Directory_2014-2015.csv')}"
#   INTO TABLE performances
#   FIELDS TERMINATED BY ','
#   OPTIONALLY ENCLOSED BY '"'
#   LINES TERMINATED BY '\n'
#   IGNORE 1 LINES
#   (dbn, @on_track_2013, @grad_rate_2013, @college_rate_2013, @student_satisfaction, @on_track_2012, @grad_rate_2012,  @college_rate_2012, @student_satisfation_2012, @on_track_sim_schools, @grad_rate_sim_schools, @college_rate_sim_schools, @student_satisfaction_sim_schools, quality_review, @x)
#   SET
#     on_track_2013 = IF(@on_track_2013 = "N/A", NULL, REPLACE(@on_track_2013, "%", '') / 100),
#     grad_rate_2013 = IF(@grad_rate_2013 = "N/A", NULL, REPLACE(@grad_rate_2013, "%", '') / 100),
#     college_rate_2013 = IF(@college_rate_2013 = "N/A", NULL, REPLACE(@college_rate_2013, "%", '') / 100),
#     student_satisfaction = IF(@student_satisfaction = "N/A", NULL, REPLACE(@student_satisfaction, "%", '')),
#     on_track_2012 = IF(@on_track_2012 = "N/A", NULL, REPLACE(@on_track_2012, "%", '') / 100),
#     grad_rate_2012 = IF(@grad_rate_2012 = "N/A", NULL, REPLACE(@grad_rate_2012, "%", '') / 100),
#     college_rate_2012 = IF(@college_rate_2012 = "N/A", NULL, REPLACE(@college_rate_2012, "%", '') / 100),
#     student_satisfation_2012 = IF(@student_satisfation_2012 = "N/A", NULL, REPLACE(@student_satisfation_2012, "%", '')),
#     on_track_sim_schools = IF(@on_track_sim_schools = "N/A", NULL, REPLACE(@on_track_sim_schools, "%", '') / 100),
#     grad_rate_sim_schools = IF(@grad_rate_sim_schools = "N/A", NULL, REPLACE(@grad_rate_sim_schools, "%", '') / 100),
#     college_rate_sim_schools = IF(@college_rate_sim_schools = "N/A", NULL, REPLACE(@college_rate_sim_schools, "%", '') / 100),
#     student_satisfaction_sim_schools = IF(@student_satisfaction_sim_schools = "N/A", NULL, REPLACE(@student_satisfaction_sim_schools, "%", ''))
#   SQL
# }

# puts Benchmark.measure{
#   sql.execute "TRUNCATE after_school_programs"
#   sql.execute <<-SQL
#   LOAD DATA INFILE "#{Rails.root.join('db','seeds','DYCD_after-school_programs.csv')}"
#   INTO TABLE after_school_programs
#   FIELDS TERMINATED BY ','
#   OPTIONALLY ENCLOSED BY '"'
#   LINES TERMINATED BY '\n'
#   IGNORE 1 LINES
#   (program, program_type, site, boro, agency, @x, grade_age_level, @loc)
#   SET
#     latitude = IF(@loc = "", NULL, SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@loc, "(", -1),")",""), ',', 1)),
#     longitude =  IF(@loc = "", NULL, SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(@loc, "(", -1),")",""), ',', -1))
#   SQL
# }

# puts Benchmark.measure{
#   sql.execute "TRUNCATE raw_safety_reports"
#   sql.execute <<-SQL
#   LOAD DATA INFILE "#{Rails.root.join('db','seeds','School_Safety_Report.csv')}"
#   INTO TABLE raw_safety_reports
#   FIELDS TERMINATED BY ','
#   OPTIONALLY ENCLOSED BY '"'
#   LINES TERMINATED BY '\n'
#   IGNORE 1 LINES
#   (@id, building, dbn, @name, @code, @add, @boro, @geo, @reg, @bname, number_schools, @inbldg, @major_crimes, @other_crimes, @incidents, @property_crimes, @violent_crimes, @eng, group_size, @avg_major_crimes, @avg_other_crimes, @avg_incidents, @avg_property_crimes, @avg_violent_crimes)
#   SET
#     major_crimes = REPLACE(@major_crimes, 'N/A', 0),
#     other_crimes = REPLACE(@other_crimes, 'N/A', 0),
#     incidents = REPLACE(@incidents, 'N/A', 0),
#     property_crimes = REPLACE(@property_crimes, 'N/A', 0),
#     violent_crimes = REPLACE(@violent_crimes, 'N/A', 0),
#     avg_major_crimes = REPLACE(@avg_major_crimes, 'N/A', 0),
#     avg_other_crimes = REPLACE(@avg_other_crimes, 'N/A', 0),
#     avg_incidents = REPLACE(@avg_incidents, 'N/A', 0),
#     avg_property_crimes = REPLACE(@avg_property_crimes, 'N/A', 0),
#     avg_violent_crimes = REPLACE(@avg_violent_crimes, 'N/A', 0)
#   SQL
# }

# puts Benchmark.measure{
#   sql.execute "TRUNCATE safety_reports"
#   sql.execute <<-SQL
#   INSERT INTO safety_reports (building, dbn, number_schools, major_crimes, other_crimes, incidents, property_crimes, violent_crimes, group_size, avg_major_crimes, avg_other_crimes, avg_incidents, avg_property_crimes, avg_violent_crimes, created_at, updated_at)
#   SELECT building, dbn, COUNT(number_schools), major_crimes, SUM(other_crimes), SUM(incidents), SUM(property_crimes), SUM(violent_crimes), group_size, SUM(avg_major_crimes), SUM(avg_other_crimes), SUM(avg_incidents), SUM(avg_property_crimes), SUM(avg_violent_crimes), created_at, updated_at
#   FROM raw_safety_reports
#   GROUP BY building;
#   SQL
#   sql.execute "UPDATE safety_reports SET number_schools = 1 WHERE number_schools = 0;"
# }