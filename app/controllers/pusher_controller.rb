class PusherController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user

  def auth
    if current_user
      response = Pusher.authenticate(params[:channel_name], params[:socket_id])
      render json: response
    else
      render text: 'Forbidden', status: '403'
    end
  end

end
