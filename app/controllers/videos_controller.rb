class VideosController < ApplicationController

  def show
    @video = Video.find(params[:id])
  end

  def search
    @categories = Category.all
    @results = Video.search_by_title(params[:search_term])
  end

end