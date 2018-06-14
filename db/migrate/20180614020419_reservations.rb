class Reservations < ActiveRecord::Migration[5.2]
  def change
  	create_table :reservations do |t|
  		t.references :user
  		t.references :listing
  		t.date :check_in
  		t.date :check_out
  		t.integer :number_of_guest
  		t.timestamps
  	end
  end
end


