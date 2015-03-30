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
  (dbn,name, boro, building,@x,@x,starting_grade, finishing_grade,@x,@x,@x,@x,@address,@city,@state,@zip,website,@total_students,@x,school_type,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@latitude,@longitude)
  SET
    total_students = REPLACE(@total_students,'N/A', 1),
    address = concat(@address, ', ', @city, ', ', @state, ' ', @zip)
  SQL
}

puts Benchmark.measure{
  sql.execute "TRUNCATE schools"
  sql.execute <<-SQL
  LOAD DATA INFILE "#{Rails.root.join('db','seeds','DOE_High_School_Directory_2014-2015.csv')}"
  INTO TABLE schools
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (dbn,name, boro, building,@x,@x,starting_grade, finishing_grade,@x,@x,@x,@x,@address,@city,@state,@zip,website,@total_students,@x,school_type,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@latitude,@longitude)
  SET
    total_students = REPLACE(@total_students,'N/A', 1),
    address = concat(@address, ', ', @city, ', ', @state, ' ', @zip)
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
  (dbn,name, boro, building,@x,@x,starting_grade, finishing_grade,@x,@x,@x,@x,@address,@city,@state,@zip,website,@total_students,@x,school_type,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@x,@latitude,@longitude)
  SET
    total_students = REPLACE(@total_students,'N/A', 1),
    address = concat(@address, ', ', @city, ', ', @state, ' ', @zip)
  SQL
}
