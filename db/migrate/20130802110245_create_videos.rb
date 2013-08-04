class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :title, :small_cover_url, :large_cover_url
      t.text :description
      t.timestamps
    end
  end

  def down
    drop_table :videos
  end
end
