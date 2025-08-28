class Chat < ApplicationRecord
  acts_as_chat

  belongs_to :plant
  has_many :messages, dependent: :destroy

end
