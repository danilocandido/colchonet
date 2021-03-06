class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email, unique: true
      t.string :password
      t.string :location
      t.text :bio

      t.timestamps
    end
  end
end
