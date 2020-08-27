class CreateBabysitters < ActiveRecord::Migration[6.0]
  def change
    create_table :babysitters do |t|
      t.string :name
      t.string :username
      t.integer :phone_number
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
