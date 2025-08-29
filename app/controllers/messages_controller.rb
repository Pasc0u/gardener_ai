class MessagesController < ApplicationController
SYSTEM_PROMPT = "You are a gardener with 30 years of experience.

I have some plants at home or in my garden, I'm quite new to taking care of plants.

Help me take care of my plants so that they can grow well.

Answer concisely in markdown."

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params.merge(role: "user", chat: @chat))
    @plant = @chat.plant
    if @message.valid? # with broadcasting don't call save anymore
      if @message.file.attached?
        @message.save
        response = process_file(@message.file)
        # This part of the code is hacky (made it with teacher's help)
        message_response = Message.new(content: response.content, chat: @chat, role: "assistant")
        message_response.save
        broadcast_replace(@chat.messages.last)
        # End of the hacky code
      else
        @chat.with_instructions(instructions).ask(@message.content) do |chunk|
          next if chunk.content.blank? # this will skip empty chunks
          message = @chat.messages.last
          message.content += chunk.content
          broadcast_replace(message)
        end
        broadcast_replace(@chat.messages.last)
      end
      if @chat.topic == "unknown"
        @chat.generate_topic_from_first_message
      end
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form", locals: { chat: @chat, message: @message }) }
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def broadcast_replace(message)
    Turbo::StreamsChannel.broadcast_replace_to(@chat, target: helpers.dom_id(message), partial: "messages/message",
    locals: { message: message})
  end

  def send_question(model: "", with: {})
    @LLMchat = RubyLLM.chat(model: model)
    @response = @LLMchat.with_instructions(instructions).ask(@message.content, with: with)
  end

  def instructions
    [SYSTEM_PROMPT, plant_infos].compact.join("\n\n")
  end

  def plant_infos
    "Here are additional informations on the plant:

    Species: #{@plant.species};

    Location; #{@plant.location};

    Is the plant potted? #{@plant.is_potted};

    optional age: #{@plant.age}"
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
