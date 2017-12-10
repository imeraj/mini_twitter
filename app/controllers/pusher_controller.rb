class PusherController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user

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
        render text: 'Bad Request', status: '400'
      end
      render json: response
    else
      render text: 'Forbidden', status: '403'
    end
  end

end
