class Performance < ActiveRecord::Base
  belongs_to :school, foreign_key: :dbn, primary_key: :dbn
end
