class CreateCoursesStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :courses_students do |t|
      t.integer "course_id", null: false
      t.integer "student_id", null: false
      t.timestamps
    end
  end
end
