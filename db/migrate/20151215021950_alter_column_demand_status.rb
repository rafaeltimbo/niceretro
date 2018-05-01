class AlterColumnDemandStatus < ActiveRecord::Migration[5.0]
  def change
  	change_table :demands do |t|
  		t.change :status, 'boolean USING CAST(status AS boolean)', :default => false
  	end
  end
end
