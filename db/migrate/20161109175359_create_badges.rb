class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
    	t.string :name
    	t.text :description
    	t.string :image
    	t.string :criteria
    	t.string :issuer

      t.timestamps null: false
    end
  end
end
