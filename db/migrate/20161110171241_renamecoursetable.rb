class Renamecoursetable < ActiveRecord::Migration
  def change
  	rename_column :courses, :learn_id, :course_id
  	rename_table :courses, :enrollments
  end
end
