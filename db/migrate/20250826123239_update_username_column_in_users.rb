class UpdateUsernameColumnInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :username, false
    change_column_default :users, :username, ""
  end
end
