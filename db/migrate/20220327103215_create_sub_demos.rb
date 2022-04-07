class CreateSubDemos < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_demos do |t|
      t.string "title"
      t.integer "demo_id", null: false
      t.timestamps
    end
  end
end
