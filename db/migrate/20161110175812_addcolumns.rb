class Addcolumns < ActiveRecord::Migration
  def change
  	add_column :courses, :title, :string
  	add_column :courses, :description, :string
  	add_column :courses, :learn_id, :integer
  end
end
