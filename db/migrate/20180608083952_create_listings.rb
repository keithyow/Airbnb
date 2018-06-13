class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
    	t.string :name
    	t.string :description
    	t.string :address
    	t.integer :price
    	t.references :user
    	t.timestamps
    end
  end
end
