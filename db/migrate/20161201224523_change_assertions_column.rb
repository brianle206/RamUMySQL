class ChangeAssertionsColumn < ActiveRecord::Migration
  def change
  	change_table :assertions do |t|
  		t.remove :issued_on
  		t.integer :issuedOn
  	end
  end
end
