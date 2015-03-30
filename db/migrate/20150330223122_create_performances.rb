class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.string :dbn
      t.decimal :on_track_2013, precision: 3, scale: 2
      t.decimal :grad_rate_2013, precision: 3, scale: 2
      t.decimal :college_rate_2013, precision: 3, scale: 2
      t.decimal :student_satisfaction, precision: 2, scale: 1
      t.decimal :on_track_2012, precision: 3, scale: 2
      t.decimal :grad_rate_2012, precision: 3, scale: 2
      t.decimal :college_rate_2012, precision: 3, scale: 2
      t.decimal :student_satisfation_2012, precision: 3, scale: 2
      t.decimal :on_track_sim_schools, precision: 3, scale: 2
      t.decimal :grad_rate_sim_schools, precision: 3, scale: 2
      t.decimal :college_rate_sim_schools, precision: 3, scale: 2
      t.decimal :student_satisfaction_sim_schools, precision: 2, scale: 1
      t.string :quality_review

      t.timestamps null: false
    end
  end
end
