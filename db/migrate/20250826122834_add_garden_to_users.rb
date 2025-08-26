class AddGardenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :garden, :string
  end
end
