class MessagesController < ApplicationController
  def index
    @messages = current_user.received_messages.new_to_old
  end

  def mark_read
    @messages = current_user.received_messages.where(id: params[:message_ids])

    @messages.each do |message|
      message.update_attribute(:read, true)
    end

    redirect_to messages_path
  end

  private

  def current_user
    User.find_by(id: cookies[:current_user_id])
  end
end
