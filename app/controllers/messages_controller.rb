class MessagesController < ApplicationController
SYSTEM_PROMPT = "You are a gardener with 30 years of experience.

I have some plants at home or in my garden, I'm quite new to taking care of plants.

Help me take care of my plants so that they can grow well.

Answer concisely in markdown."

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.role = "user"
    @message.chat = @chat
    if @message.save
      if @message.file.attached?
        process_file(@message.file)
      else
        send_question
      end
      Message.create(role: "assistant", content: @response.content, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def send_question(model: "gpt-4.1-nano", with: {})
    @LLMchat = RubyLLM.chat(model: model)
    @response = @LLMchat.with_instructions(SYSTEM_PROMPT).ask(@message.content, with: with)
  end

  def process_file(file)
    if file.content_type == "application/pdf"
      send_question(model: "gemini-2.0-flash", with: { pdf: @message.file.url })
    elsif file.image?
      send_question(model: "gpt-4o", with: { image: @message.file.url })
    end
  end

  def message_params
    params.require(:message).permit(:content, :file)
  end
end
