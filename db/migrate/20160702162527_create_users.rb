class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.integer :role, default: User::CUSTOMER_ROLE_ID, null: false
      t.string :password, null: false

      t.timestamps null: false
    end

    add_index :users, :email, :unique => true
  end
end
