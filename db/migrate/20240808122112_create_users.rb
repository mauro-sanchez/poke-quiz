class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.index :username, unique: true
      t.index :email, unique: true

      t.timestamps
    end
  end
end
