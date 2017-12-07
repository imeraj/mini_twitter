class SearchController < ApplicationController
  before_action :logged_in_user

  def search
    @user = current_user
    if params[:term].nil?
        @microposts = []
    else
      @microposts = Micropost.search(params[:term])
      @microposts = @microposts.select { |s| s.user_id == @user.id or
                                         s.user.followers_ids.include?(@user.id)
                                       }
    end
  end

end
