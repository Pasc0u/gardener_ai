class Plant < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy
  has_many :messages, through: :chats

  validates :species, :nickname, presence: true
  validates :location, presence: true, inclusion: { in: ["sunny", "semi-shade", "shade"] }
end
