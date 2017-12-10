module PusherHelper
  PUSHER_CHANNEL = 'miniTwitter-channel'
  PUSHER_EVENT_FOLLOW   = 'miniTwitter-event-follow'
  PUSHSER_EVENT_LOGOUT  = 'miniTwitter-event-logout'

  def pusher_trigger_event(event, user)
    self.send("pusher_trigger_#{event}", user)
  end

  def pusher_trigger_follow(user)
    Pusher.trigger(PUSHER_CHANNEL, "#{PUSHER_EVENT_FOLLOW}-#{user.id}", {
      message: "#{current_user.name} is following you!"
    })
  end

  def pusher_trigger_logout(user)
    Pusher.trigger(PUSHER_CHANNEL, "#{PUSHSER_EVENT_LOGOUT}-#{user.id}", {
      message: ""
    })
  end
  
end
