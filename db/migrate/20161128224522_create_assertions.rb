class CreateAssertions < ActiveRecord::Migration
  def change
    create_table :assertions do |t|
    	t.integer :user_id
    	t.integer :badge_id
    	t.string :uid
    	t.text :recipient
    	t.string :badge
    	t.text :verify
    	t.datetime :issued_on
    	t.datetime :expires

    	t.string :token
    	t.boolean :is_baked

      t.timestamps null: false
    end
  end
end
