class DropAssertions < ActiveRecord::Migration
  def change
  	drop_table :assertions
  end
end
