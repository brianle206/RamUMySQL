class CreateUserExamResults < ActiveRecord::Migration
  def change
    create_table :user_exam_results do |t|
      t.integer :exam_id
      t.integer :user_id
      t.integer :score
      t.integer :attempts
      t.boolean{default :passing
      t.string :false}

      t.timestamps null: false
    end
  end
end
