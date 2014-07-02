class AddUsernameAndPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :password_digest, :string

    add_index :users, :username, unique: true
  end
end
