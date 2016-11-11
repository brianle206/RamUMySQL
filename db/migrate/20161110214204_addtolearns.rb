class Addtolearns < ActiveRecord::Migration
  def change
  	remove_column :courses, :learn_id
  end

end
