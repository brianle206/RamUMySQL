class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstName
      t.string :lastName
      t.string :address
      t.string :country
      t.string :state
      t.integer :zipcode
      t.integer :phoneNumber
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
