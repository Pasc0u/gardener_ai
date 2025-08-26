class Plant < ApplicationRecord
  belongs_to :user
  has_many :chats

  validates :species, :is_potted, :location, presence: true
end
