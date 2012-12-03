class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :gender
      t.string :image
      t.string :location
      t.string :bio
      t.string :birthday
      t.string :likes
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
