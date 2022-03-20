class AddCustomAttributesToUser < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_number, :string
    add_column :users, :address, :string
    add_column :users, :username, :string
  end

  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :contact_number, :string
    remove_column :users, :address, :string
    remove_column :users, :username, :string
  end
end
