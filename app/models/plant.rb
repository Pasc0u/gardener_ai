class Plant < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy
  has_many :messages, through: :chats

  validates :species, :location, presence: true
end
