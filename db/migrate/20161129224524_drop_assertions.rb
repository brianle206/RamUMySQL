class DropAssertions < ActiveRecord::Migration
  def change
  	drop_table :assertions do |t|
  	end
  end
end
