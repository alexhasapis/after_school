class School < ActiveRecord::Base
  has_one :performance, foreign_key: :dbn, primary_key: :dbn
  has_one :safety_report, foreign_key: :building, primary_key: :building
end
