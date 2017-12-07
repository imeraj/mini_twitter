class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      p "count"
      p @feed_items.count
    end
  end

  def help
  end

  def about
  end

end
