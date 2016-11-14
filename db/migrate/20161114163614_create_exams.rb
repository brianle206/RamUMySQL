class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :course_id
      t.string :title

      t.timestamps null: false
    end
  end
end
