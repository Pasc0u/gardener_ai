class Message < ApplicationRecord
  belongs_to :chat
  has_one :plant, through: :chat

  validates :content, :role, presence: true
end
