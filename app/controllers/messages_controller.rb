class MessagesController < ApplicationController
  def create
    Message.create!(user: current_user)

    head :ok
  end

  def upvote
    @message = Message.find(params[:id])

    @message.update(upvoted: true)

    head :ok
  end

  def destroy
    @message = Message.find(params[:id])

    @message.destroy

    head :ok
  end
end
