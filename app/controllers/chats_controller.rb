class ChatsController < ApplicationController
  def index
    chats = Chat.all
    plant = Plant.find(params[:plant_id])
  end

  def new
    plant = Plant.find(params[:plant_id])
    chat = Chat.new
  end

  def create
    # chat = Chat.new(topic: "unknown", params[:plant_id])
  end
end
