class Plant < ApplicationRecord
  belongs_to :user
  has_many :chats
  has_many :messages, through: :chats

  validates :species, :location, presence: true
end
