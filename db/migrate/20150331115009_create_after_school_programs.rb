class CreateAfterSchoolPrograms < ActiveRecord::Migration
  def change
    create_table :after_school_programs do |t|
      t.string :program
      t.string :program_type
      t.string :site
      t.string :boro
      t.string :agency
      t.string :grade_age_level
      t.decimal :latitude, precision: 16, scale: 14 
      t.decimal :longitude, precision: 16, scale: 14

      t.timestamps null: false
    end
  end
end
