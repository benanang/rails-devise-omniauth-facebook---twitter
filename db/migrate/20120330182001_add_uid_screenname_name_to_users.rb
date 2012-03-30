class AddUidScreennameNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screen_name, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
  end
end
