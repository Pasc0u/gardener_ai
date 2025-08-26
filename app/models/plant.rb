class Plant < ApplicationRecord
  belongs_to :user

  validates :species, :is_potted, :location, presence: true
end
