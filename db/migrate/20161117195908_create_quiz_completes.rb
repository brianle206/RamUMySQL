class CreateQuizCompletes < ActiveRecord::Migration
  def change
    create_table :quiz_completes do |t|
    	t.integer :user_id
    	t.integer :quiz_id
    	t.boolean :status

    	t.timestamps null: false
    end
  end
end
