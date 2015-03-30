class School < ActiveRecord::Base
  has_one :performance, foreign_key: :dbn, primary_key: :dbn
end
