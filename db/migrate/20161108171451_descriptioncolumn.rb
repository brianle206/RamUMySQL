class Descriptioncolumn < ActiveRecord::Migration
  def change
  	add_column :learns, :description, :string
  	add_column :learns, :img, :string
  end
end
