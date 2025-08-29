class Message < ApplicationRecord
  acts_as_message

  belongs_to :chat
  has_one :plant, through: :chat
  has_one_attached :file

  validates :role, presence: true

  validate :file_size_validation
  validates :content, length: { minimum: 10, maximum: 1000 }, if: -> { role == "user" }

  after_create_commit :broadcast_append_to_chat

  MAX_FILE_SIZE_MB = 10

  private

  def file_size_validation
    if file.attached? && file.byte_size > MAX_FILE_SIZE_MB.megabytes
      errors.add(:file, "size must be less than #{MAX_FILE_SIZE_MB}MB")
    end
  end

  def broadcast_append_to_chat
    return unless role.in?(["user", "assistant"])

    broadcast_append_to chat, target: "messages",  partial: "messages/message", locals: { message: self }
  end
end
