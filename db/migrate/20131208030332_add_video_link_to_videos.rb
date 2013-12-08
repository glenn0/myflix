class AddVideoLinkToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video_link, :string
  end
end
