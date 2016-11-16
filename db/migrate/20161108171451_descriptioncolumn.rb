class Descriptioncolumn < ActiveRecord::Migration
  def change
  	add_column :learns, :description, :string
  	add_column :learns, :img, :string
  	add_column :learns, :course_id, :integer
  end
end
