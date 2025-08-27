class MessagesController < ApplicationController
SYSTEM_PROMPT = "You are a gardener with 30 years of experience.

I have some plants at home or in my garden, quite new to taking care of plants.

Help me take care of my plants so that they can grow well.

Answer concisely in markdown."

  def index
    @messages = Message.all
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(role: "user", content: params[:message][:content], chat: @chat)
    if @message.save
      @chat = RubyLLM.save
      response = @chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render :new
    end
  end

  # private

  # def message_params
  #   params.require(:message).permit(:content)
  # end
end
