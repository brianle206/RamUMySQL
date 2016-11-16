class AddCourseIdToBadges < ActiveRecord::Migration
  def change
  	add_column :badges, :course_id, :integer
  end
end
