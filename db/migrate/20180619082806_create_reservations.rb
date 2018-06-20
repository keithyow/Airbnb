class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
    	t.date :start
    	t.date :end
    	t.integer :guest
    	t.references :user
    	t.references :listing
    	t.timestamp
    end
  end
end
