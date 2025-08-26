class ChatsController < ApplicationController

  def create
    @plant = Plant.find(params[:plant_id])
    @chat = Chat.new(topic: "unkown")
    @chat.plant = @plant
    @chat.save
    redirect_to chat_path(@chat)
  end

  def show
    @plant = Plant.find(params[:plant_id])
    @chat = Chat.find(params[:id])
  end
end
