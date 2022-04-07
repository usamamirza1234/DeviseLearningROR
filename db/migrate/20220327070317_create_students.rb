class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :date_of_birth
      t.string :permanent_address
      t.string :local_address
      t.string :permanent_contact_number
      t.string :alternative_contact_number
      t.timestamps
    end
  end
end
