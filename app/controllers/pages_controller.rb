class PagesController < ApplicationController
  def home
    @videos = Video.all
  end
end