class Message < ApplicationRecord
  belongs_to :chat
  has_one :plant, through: :chat
  has_one_attached :file

  validates :content, :role, presence: true
end
