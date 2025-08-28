class ChatsController < ApplicationController

  def create
    @plant = Plant.find(params[:plant_id])
    @chat = Chat.new(topic: "unkown", model_id: "gpt-4.1-nano")
    @chat.plant = @plant
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render "plants/show"
    end
  end

  def show
    @chat = Chat.find(params[:id])
    # @chat.plant = @plant
    @plant = @chat.plant
    @message = Message.new
    @messages = Message.all
  end
end
