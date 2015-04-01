class School < ActiveRecord::Base
  has_one :performance, foreign_key: :dbn, primary_key: :dbn
  has_many :safety_reports, foreign_key: :building, primary_key: :building
end
