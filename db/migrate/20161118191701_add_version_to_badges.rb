class AddVersionToBadges < ActiveRecord::Migration
  def change
  	add_column :badges, :version, :string
  end
end
