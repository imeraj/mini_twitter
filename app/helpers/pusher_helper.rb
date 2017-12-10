module PusherHelper
  PUSHER_CHANNEL = 'private-miniTwitter-channel'
  PUSHER_EVENT_FOLLOW   = 'miniTwitter-event-follow'
  PUSHSER_EVENT_LOGOUT  = 'miniTwitter-event-logout'

  def pusher_trigger_event(event, user)
    self.send("pusher_trigger_#{event}", user)
  end

  def pusher_trigger_follow(user)
    Pusher.trigger("#{PUSHER_CHANNEL}-#{user.id}", "#{PUSHER_EVENT_FOLLOW}", {
      message: "#{current_user.name} is following you!"
    })
  end

  def pusher_trigger_logout(user)
    Pusher.trigger("#{PUSHER_CHANNEL}-#{user.id}", "#{PUSHSER_EVENT_LOGOUT}", {
      message: ""
    })
  end

end
