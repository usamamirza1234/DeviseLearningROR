class CreateStudentProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :student_projects do |t|
      t.integer "student_id", null: false
      t.integer "project_id", null: false
      t.date "submission_date"
      t.timestamps
    end
  end
end
