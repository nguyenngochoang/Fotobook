class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    user_id = Photo.find(notification.target_id).photoable.id
    user = User.find(user_id)
    counter = user.notifications.size

    ActionCable.server.broadcast "user_#{user_id}",  counter: counter, notification: render_notification(notification)
  end

  private

  def render_notification(notification)
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { noti: notification })
  end
end
