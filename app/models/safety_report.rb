class SafetyReport < ActiveRecord::Base
  belongs_to :school, foreign_key: :building, primary_key: :building
end
