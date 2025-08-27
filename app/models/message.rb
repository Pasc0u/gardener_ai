class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :plant, through :chats

  validates :content, :role, presence: true
end
