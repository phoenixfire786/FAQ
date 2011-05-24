class RemovePasswordFromEmployees < ActiveRecord::Migration
  def self.up
    remove_column :employees, :password
  end

  def self.down
    add_column :employees, :password, :string
  end
end
