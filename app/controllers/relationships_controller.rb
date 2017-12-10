require 'pusher'

class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    user_info = {
      id: user.id,
      name: user.name,
      email: user.email
    }

    current_user.follow(user)
    pusher_trigger_event(:follow, user_info)
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end

end
