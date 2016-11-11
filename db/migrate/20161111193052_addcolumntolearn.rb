class Addcolumntolearn < ActiveRecord::Migration
  def change
  	add_column :learns, :course_id, :integer
  end
end
