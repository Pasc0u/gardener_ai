class Plant < ApplicationRecord
  belongs_to :user
  has_many :chats

  validates :species, :location, presence: true
end
