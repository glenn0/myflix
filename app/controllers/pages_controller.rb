class PagesController < ApplicationController
  def home
    @videos = Video.all
    @categories = Category.all
  end
end