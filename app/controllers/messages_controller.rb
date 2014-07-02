class MessagesController < ApplicationController
  before_action :require_current_user

  def index
    @messages = current_user.received_messages.new_to_old.includes(:sender)
  end

  def mark_read
    @messages = current_user.received_messages.where(id: params[:message_ids])

    @messages.update_all(read: true, updated_at: Time.current)

    redirect_to messages_path
  end

  private

  def require_current_user
    unless current_user
      redirect_to login_path, flash: { alert: "Please log in first." }
    end
  end

  def current_user
    User.find_by(id: cookies[:current_user_id])
  end
end
