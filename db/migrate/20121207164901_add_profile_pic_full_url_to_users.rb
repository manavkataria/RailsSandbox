class AddProfilePicFullUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ProfilePicFullURL, :string
  end
end
