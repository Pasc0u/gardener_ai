class AddModelToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :model_id, :string, default: "gpt-4.1-nano"
  end
end
