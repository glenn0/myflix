module ApplicationHelper
  def options_for_video_rating(selected=nil)
    options_for_select([["5", 5], ["4", 4], ["3", 3], ["2", 2], ["1", 1]], selected)
  end
end
