class CreateSafetyReports < ActiveRecord::Migration
  def change
    create_table :safety_reports do |t|
      t.string :building
      t.string :dbn
      t.integer :major_crimes
      t.integer :other_crimes
      t.integer :incidents
      t.integer :property_crimes
      t.integer :violent_crimes
      t.integer :number_schools
      t.string :group_size
      t.decimal :avg_major_crimes, precision: 4, scale: 2
      t.decimal :avg_other_crimes, precision: 4, scale: 2
      t.decimal :avg_incidents, precision: 4, scale: 2
      t.decimal :avg_property_crimes, precision: 4, scale: 2
      t.decimal :avg_violent_crimes, precision: 4, scale: 2

      t.timestamps null: false
    end
  end
end
