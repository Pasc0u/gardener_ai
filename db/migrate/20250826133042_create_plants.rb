class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :nickname
      t.string :species
      t.string :image
      t.integer :age
      t.boolean :is_potted
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
