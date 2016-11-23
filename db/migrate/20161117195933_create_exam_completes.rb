class CreateExamCompletes < ActiveRecord::Migration
  def change
    create_table :exam_completes do |t|
    	t.integer :user_id
    	t.integer :exam_id
    	t.boolean :status

    	t.timestamps null: false
    end
  end
end
