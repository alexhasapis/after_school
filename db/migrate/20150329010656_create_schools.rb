class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :dbn
      t.string :name
      t.string :boro
      t.string :building
      t.string :starting_grade
      t.string :finishing_grade
      t.string :address
      t.string :website
      t.integer :total_students
      t.string :school_type
      t.decimal :latitude, precision: 10, scale: 8
      t.decimal :longitude, precision: 11, scale: 8

      t.timestamps null: false
    end
  end
end
