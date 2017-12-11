class PusherController < ApplicationController
  skip_before_action :verify_authenticity_token

  def auth
    if current_user
      channel_name = params[:channel_name]
      if channel_name.eql?(PUSHER_PRESENCE_CHANNEL)
        response = Pusher.authenticate(params[:channel_name], params[:socket_id], {
          user_id: current_user.id,
          user_info: {
            name: current_user.name,
            email: current_user.email
          }
        })
      elsif channel_name.eql?("#{PUSHER_CHANNEL}-#{current_user.id}")
        response = Pusher.authenticate(params[:channel_name], params[:socket_id])
      else
        render template: "errors/400", text: 'Bad Request', status: '400'
      end
      render json: response
    else
      render template: "errors/403", text: 'Forbidden', status: '403'
    end
  end

  def webhook
    online_ids = []
    offline_ids = []

    webhook = Pusher::WebHook.new(request)
    if webhook.valid?
      webhook.events.each do |event|
        case event["name"]
          when 'member_added'
            online_ids << "#{event["user_id"]}".to_i
          when 'member_removed'
            offline_ids << "#{event["user_id"]}".to_i
        end
      end
      set_status(offline_ids, false)
      set_status(online_ids, true)
    end
    render template: "errors/401", text: 'Unauthorized', status: '401'
  end

end
