class Chat < ApplicationRecord
  TOPIC_PROMPT = <<~PROMPT
  Generate a short, descriptive, 3-to-6-word topic title that summarizes the user question for a chat conversation.
  PROMPT

  def generate_topic_from_first_message
    first_user_message = messages.where(role: "user").order(:created_at).first
    return if first_user_message.nil?

    response = RubyLLM.chat.with_instructions(TOPIC_PROMPT).ask(first_user_message.content)
    update(topic: response.content)
  end

  acts_as_chat

  belongs_to :plant
  has_many :messages, dependent: :destroy

end
