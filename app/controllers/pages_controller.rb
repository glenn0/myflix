class PagesController < ApplicationController
  def front
    redirect_to home_path if current_user
  end

  def home
    @videos = Video.all
    @categories = Category.all
  end
end